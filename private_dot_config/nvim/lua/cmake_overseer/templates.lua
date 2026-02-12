-- lua/cmake_overseer/templates.lua
local overseer = require("overseer")
local presets = require("cmake_overseer.presets")
local fileapi = require("cmake_overseer.fileapi")
local session = require("cmake_overseer.session")

local M = {
	ctx = {
		configure_preset = nil,
		build_preset = nil,
		launch_target = nil,
		binary_dir = nil,
		configuration = nil, -- e.g. Debug/Release for multi-config
	},
}

local function pick(items, prompt, cb)
	local ok, fzf = pcall(require, "fzf-lua")
	if ok then
		fzf.fzf_exec(items, {
			prompt = prompt,
			winopts = {
				height = 0.8,
				width = 0.8,
				row = 0.5,
				col = 0.5,
				border = "rounded",
			},
			actions = {
				["default"] = function(selected)
					if selected and selected[1] then
						cb(selected[1])
					end
				end,
			},
		})
	else
		vim.ui.select(items, { prompt = prompt }, function(choice)
			if choice then
				cb(choice)
			end
		end)
	end
end

local function expand(str, vars)
	if type(str) ~= "string" then
		return str
	end
	-- minimal: ${sourceDir}, ${presetName}, ${hostSystemName}, env vars if you want later
	str = str:gsub("%${sourceDir}", vars.sourceDir or "")
	str = str:gsub("%${presetName}", vars.presetName or "")
	return str
end

local function extract_names_and_infos(objs, predicate)
	local names = {}
	local infos = {}
	for _, p in ipairs(objs) do
		if not predicate or predicate(p) then
			if p.name then
				table.insert(names, p.name)
				infos[p.name] = p
			else
				print("BUG: preset missing name field: " .. vim.inspect(p) .. " " .. vim.inspect(objs))
			end
		end
	end
	return names, infos
end

local function ensure_configure(ctx, on_ready, force)
	if not force and ctx.configure_preset and ctx.binary_dir then
		on_ready(ctx)
		return
	end

	if not force and not ctx.configure_preset then
		local state = session.load_state()
		if state.configure_preset then
			ctx.configure_preset = state.configure_preset
			-- We still need to resolve binary_dir from the preset data
			local p = presets.load()
			for _, cfg in ipairs(p.configure) do
				if cfg.name == ctx.configure_preset then
					ctx.binary_dir = expand(cfg.binaryDir, cfg.substitutions or {})
					on_ready(ctx)
					return
				end
			end
		end
	end

	local p, err = presets.load()
	if not p then
		vim.notify(err, vim.log.levels.ERROR)
		return
	end

	local cfg_names, cfg_infos = extract_names_and_infos(p.configure, function(c)
		if c.hidden then
			return false
		end
		if not c.binaryDir or c.binaryDir == "" then
			vim.notify(
				"Skipping preset " .. c.name .. " due to missing binaryDir" .. vim.inspect(c),
				vim.log.levels.WARN
			)
			return false
		end
		return true
	end)

	if #cfg_names == 0 then
		vim.notify("No visible configure presets found in CMakePresets.json", vim.log.levels.ERROR)
		return
	end

	pick(cfg_names, "CMake configure preset:", function(cfg_name)
		if not cfg_name then
			vim.notify("Configure cancelled", vim.log.levels.INFO)
			return
		end

		local cfg = cfg_infos[cfg_name]

		local binary_dir = expand(cfg.binaryDir, cfg.substitutions or {})
		if not vim.uv.fs_stat(binary_dir) then
			vim.fn.mkdir(binary_dir, "p")
		end

		local query_dir = vim.fs.joinpath(binary_dir, ".cmake/api/v1/query")
		if not vim.uv.fs_stat(query_dir) then
			vim.fn.mkdir(query_dir, "p")
		end

		local query_file = vim.fs.joinpath(query_dir, "codemodel-v2")

		local fd = vim.uv.fs_open(query_file, "w", 438)
		if not fd then
			vim.notify("Failed to open File API query file: " .. query_file, vim.log.levels.ERROR)
			return
		end
		vim.uv.fs_close(fd)

		local cmd = {}
		if cfg_name:match("^Builtin ") then
			-- Special handling for Builtin presets: Use cmake -B <binary_dir> -S <source_dir>
			cmd = {
				"cmake",
				"-B",
				binary_dir,
				"-S",
				p.sourceDir,
				"-G",
				cfg.generator,
				"-DCMAKE_EXPORT_COMPILE_COMMANDS=ON",
			}
		else
			cmd = { "cmake", "--preset", cfg_name, "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" }
		end

		local task = overseer.new_task({
			name = "cmake: configure (" .. cfg_name .. ")",
			cmd = cmd,
			cwd = p.sourceDir,
			components = { "default", { "open_output", focus = false } },
		})

		task:subscribe("on_complete", function(t)
			if t.status == "SUCCESS" then
				ctx.configure_preset = cfg_name
				ctx.binary_dir = binary_dir
				ctx.cache_variables = cfg.cacheVariables or {}
				local compile_commands = vim.fs.joinpath(ctx.binary_dir, "compile_commands.json")
				local compile_commands_link = vim.fs.joinpath(p.sourceDir, "compile_commands.json")
				if vim.uv.fs_stat(compile_commands) then
					vim.uv.fs_symlink(compile_commands, compile_commands_link)
				end
				assert(ctx.binary_dir ~= nil and ctx.binary_dir ~= "", "binary_dir should be set after configure")
				session.save_state(ctx)
				on_ready(ctx)
			else
				vim.notify("Configure failed", vim.log.levels.WARN)
			end
		end)

		task:start()
	end)
end

local function build_preset_valid(p, ctx)
	if not ctx.build_preset then
		return false
	end
	local b = nil
	for _, x in ipairs(p.build or {}) do
		if x.name == ctx.build_preset then
			b = x
			break
		end
	end
	if not b or b.hidden then
		return false
	end
	return b.configurePreset == ctx.configure_preset
end

local function ensure_build(ctx, on_ready, force)
	local p, err = presets.load()
	if not p then
		vim.notify(err, vim.log.levels.ERROR)
		return
	end

	-- 1. Ensure we have a valid configuration first.
	-- If 'force' is true, we usually want to re-pick the build preset,
	-- but not necessarily the configure preset unless that's also forced.
	ensure_configure(ctx, function(ctx2)
		-- 2. Check if we already have a valid build preset in the session
		if not force and build_preset_valid(p, ctx2) then
			local build = nil
			for _, x in ipairs(p.build or {}) do
				if x.name == ctx2.build_preset then
					build = x
					break
				end
			end
			ctx2.configuration = build and build.configuration or ctx2.cache_variables.CMAKE_BUILD_TYPE or "Debug"
			on_ready(ctx2)
			return
		end

		-- 3. Check for a saved build preset on disk (across-session)
		if not force and not ctx2.build_preset then
			local state = session.load_state() -- Implementation from previous step
			if state.build_preset then
				ctx2.configuration = state.configuration or state.cache_variables.CMAKE_BUILD_TYPE or "Debug"
				ctx2.build_preset = state.build_preset
				if build_preset_valid(p, ctx2) then
					on_ready(ctx2)
					return
				end
			end
		end

		-- 4. Fallback: Prompt the user to pick
		local build_names, build_infos = extract_names_and_infos(p.build, function(b)
			return not b.hidden and b.configurePreset == ctx2.configure_preset
		end)

		if #build_names == 0 then
			vim.notify("No build presets found for configure preset: " .. ctx2.configure_preset, vim.log.levels.ERROR)
			return
		end

		pick(build_names, "Choose build preset:", function(build_name)
			if not build_name then
				vim.notify("Build cancelled", vim.log.levels.INFO)
				return
			end

			local build = build_infos[build_name]
			ctx2.build_preset = build_name
			ctx2.configuration = build.configuration or ctx2.cache_variables.CMAKE_BUILD_TYPE or "Debug"
			session.save_state(ctx2) -- Save selection to disk
			on_ready(ctx2)
		end)
	end, false) -- Usually, build reselect doesn't force a configure reselect
end

function M.configure()
	ensure_configure(M.ctx, function(_) end, false)
end

function M.reselect_configure()
	ensure_configure(M.ctx, function()
		vim.notify("Configure preset updated: " .. M.ctx.configure_preset)
	end, true) -- force = true
end

-- Force a re-pick of the build preset
function M.reselect_build()
	-- We pass true to ensure_build (which you should update to handle the flag)
	ensure_build(M.ctx, function()
		vim.notify("Build preset updated: " .. M.ctx.build_preset)
	end, true)
end

function M.reselect_launch()
	M.launch(true)
end

function M.build(on_complete)
	ensure_build(M.ctx, function(ctx)
		local cmd = {}

		if ctx.build_preset:match("^Builtin ") then
			-- Special handling for Builtin presets: Use cmake --build <binary_dir> --config <configuration>
			cmd = { "cmake", "--build", ctx.binary_dir, "--config", ctx.configuration }
		else
			cmd = { "cmake", "--build", "--preset", ctx.build_preset }
		end
		local task = overseer.new_task({
			name = "cmake: build (" .. ctx.build_preset .. ")",
			cmd = cmd,
			cwd = presets.load().sourceDir, -- or store p.sourceDir in ctx if you like
			components = { "default", { "open_output", focus = false } },
		})
		if on_complete then
			task:subscribe("on_complete", function(t)
				if t.status == "SUCCESS" then
					on_complete()
				end
			end)
		end
		task:start()
	end, false)
end

function M.run_target(tgt_name)
	-- IDE behavior: Always build before running to ensure the binary is fresh
	M.build(function()
		local ctx = M.ctx
		-- Re-query the File API after build to ensure we have the latest artifact paths
		local targets, terr = fileapi.list_targets(ctx.binary_dir, ctx.configuration)
		if not targets then
			vim.notify("Run failed: " .. (terr or "Unknown error"), vim.log.levels.ERROR)
			return
		end

		-- Resolve target info
		local _, target_infos = extract_names_and_infos(targets, function(tgt)
			return tgt.name == tgt_name
		end)

		local tgt_info = target_infos[tgt_name]
		if not tgt_info then
			vim.notify("Target " .. tgt_name .. " not found in build index", vim.log.levels.ERROR)
			return
		end

		-- Locate binary path
		local artifact = tgt_info.artifacts and tgt_info.artifacts[1] and tgt_info.artifacts[1].path
		if not artifact then
			vim.notify("No artifacts found for target: " .. tgt_name, vim.log.levels.ERROR)
			return
		end

		local program = vim.fs.joinpath(ctx.binary_dir, artifact)
		if not vim.uv.fs_stat(program) then
			vim.notify("Binary not found: " .. program, vim.log.levels.ERROR)
			return
		end

		-- Launch the executable
		overseer
			.new_task({
				name = "run: " .. tgt_name,
				cmd = "sleep 0.5 && " .. program,
				cwd = vim.fs.dirname(program),
				components = { "default", { "open_output", focus = false } },
			})
			:start()
	end)
end

function M.launch(force_reselect)
	ensure_build(M.ctx, function(ctx)
		assert(ctx.binary_dir and ctx.configuration, "binary_dir and configuration should be set after ensure_build")

		-- Check if we have a cached target
		if not force_reselect then
			if not ctx.launch_target then
				local state = session.load_state()
				if state.launch_target then
					ctx.launch_target = state.launch_target
					M.run_target(ctx.launch_target)
				end
			else
				M.run_target(ctx.launch_target)
			end
			return
		end
		local targets, terr = fileapi.list_targets(ctx.binary_dir, ctx.configuration)
		if not targets then
			vim.notify(terr, vim.log.levels.WARN)
			return
		end

		local target_names, target_infos = extract_names_and_infos(targets, function(tgt)
			return tgt.type == "EXECUTABLE" or tgt.type == "UTILITY"
		end)
		if #target_names == 0 then
			vim.notify("No executable targets found among: " .. vim.inspect(targets), vim.log.levels.INFO)
			return
		end

		pick(target_names, "Choose target to launch:", function(tgt_name)
			if not tgt_name then
				vim.notify("Launch cancelled", vim.log.levels.INFO)
				return
			end
			local tgt_info = target_infos[tgt_name]
			local program = tgt_info.artifacts and tgt_info.artifacts[1] and tgt_info.artifacts[1].path
			program = vim.fs.joinpath(ctx.binary_dir, program)
			if not vim.uv.fs_stat(program) then
				vim.notify("Executable not found: " .. program, vim.log.levels.ERROR)
				return
			end
			ctx.launch_target = tgt_name
			if session and session.save_state then
				session.save_state(ctx)
			end

			-- Hand off to the run chain (Build -> Run)
			M.run_target(tgt_name)
		end)
	end, false)
end

function M.test()
	ensure_configure(M.ctx, function(ctx)
		local cfg = nil
		for _, c in ipairs(p.configure) do
			if c.name == cfg_name then
				cfg = c
			end
		end
		if not cfg or cfg.binaryDir == "" then
			return vim.notify("Preset missing binaryDir", vim.log.levels.ERROR)
		end

		overseer
			.new_task({
				name = "ctest (" .. cfg_name .. ")",
				cmd = { "ctest", "--test-dir", cfg.binaryDir, "--output-on-failure" },
				cwd = p.sourceDir,
				components = { "default" },
			})
			:start()
	end)
end

return M
