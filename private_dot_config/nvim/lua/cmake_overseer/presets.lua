-- lua/cmake_overseer/presets.lua
local M = {}

local function read_json(path)
	local file = io.open(path, "r")
	if not file then
		return nil
	end
	local content = file:read("*a")
	file:close()
	return vim.json.decode(content)
end

function M.load(source_dir)
	source_dir = vim.fs.normalize(source_dir or vim.loop.cwd())
	local presets_path = vim.fs.joinpath(source_dir, "CMakePresets.json")
	local data = read_json(presets_path)
	if not data then
		return {
			sourceDir = source_dir,
			is_fallback = true,
			configure = {
				{
					name = "Builtin Default",
					binaryDir = "build/default",
					generator = "Ninja Multi-Config",
					cacheVariables = { CMAKE_BUILD_TYPE = "Debug" },
				},
			},
			build = {
				{ name = "Builtin Debug", configurePreset = "Builtin Default", configuration = "Debug" },
				{ name = "Builtin Release", configurePreset = "Builtin Default", configuration = "Release" },
			},
		}
	end

	local cfgs = {}
	for _, p in ipairs(data.configurePresets or {}) do
		local candidate_cfg = {
			name = p.name,
			binaryDir = p.binaryDir or "",
			generators = p.generator,
			hidden = p.hidden or false,
			cacheVariables = p.cacheVariables or {},
			substitutions = { sourceDir = source_dir, presetName = p.name },
		}
		-- The preset will inherit all of the fields from the inherits presets
		-- by default (except name, hidden, inherits, description, and
		-- displayname), but can override them as desired. If multiple inherits
		-- presets provide conflicting values for the same field, the earlier
		-- preset in the inherits array will be preferred.
		for _, name_to_inherit in ipairs(p.inherits or {}) do
			local found_parent = false
			for _, parent in ipairs(cfgs) do
				if parent.name == name_to_inherit then
					-- Inherit if not already set in candidate: Prefer candidate's own values and prefer earlier parents
					if
						parent.binaryDir
						and parent.binaryDir ~= ""
						and (not candidate_cfg.binaryDir or candidate_cfg.binaryDir == "")
					then
						candidate_cfg.binaryDir = parent.binaryDir
					end
					if
						parent.generator
						and parent.generator ~= ""
						and (not candidate_cfg.generator or candidate_cfg.generator == "")
					then
						candidate_cfg.generator = parent.generator
					end
					if parent.cacheVariables then
						vim.tbl_extend("keep", candidate_cfg.cacheVariables, parent.cacheVariables)
					end
					found_parent = true
					break
				end
			end
			if not found_parent then
				return nil, ("Parent preset " .. name_to_inherit .. " not found for " .. p.name)
			end
		end

		table.insert(cfgs, candidate_cfg)
	end

	local builds = {}
	for _, p in ipairs(data.buildPresets or {}) do
		table.insert(builds, {
			name = p.name,
			configurePreset = p.configurePreset,
			configuration = p.configuration, -- Debug/Release for multi-config
		})
	end

	local tests = {}
	for _, p in ipairs(data.testPresets or {}) do
		table.insert(tests, { name = p.name, configurePreset = p.configurePreset })
	end

	return {
		sourceDir = source_dir,
		presetsPath = presets_path,
		configure = cfgs,
		build = builds,
		test = tests,
	}
end

return M
