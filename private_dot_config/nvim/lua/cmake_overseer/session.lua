local presets = require("cmake_overseer.presets")

local M = {}

function M.get_state_path()
	local p = presets.load()
	if not p then
		return nil
	end
	return vim.fs.joinpath(p.sourceDir, ".cmake_overseer.json")
end

function M.save_state(ctx)
	local path = M.get_state_path()
	if not path then
		return
	end
	if not ctx.configure_preset or not ctx.binary_dir then
		vim.notify("Cannot save session state: incomplete context: " .. vim.inspect(ctx), vim.log.levels.WARN)
		return
	end
	local f = io.open(path, "w")
	if f then
		-- Only save the selections, not the binary_dir which might change or be expanded
		local data = {
			configure_preset = ctx.configure_preset,
			build_preset = ctx.build_preset,
			configuration = ctx.configuration,
			launch_target = ctx.launch_target,
		}
		f:write(vim.json.encode(data))
		f:close()
	end
end

function M.load_state()
	local path = M.get_state_path()
	if not path or vim.fn.filereadable(path) == 0 then
		return {}
	end
	local f = io.open(path, "r")
	if not f then
		return {}
	end
	local content = f:read("*a")
	f:close()
	local ctx = vim.json.decode(content)
	if not ctx or type(ctx) ~= "table" or not ctx.configure_preset or not ctx.binary_dir then
		return {}
	end
	return ctx or {}
end

return M
