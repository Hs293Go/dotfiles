-- lua/cmake_overseer/fileapi.lua
local M = {}

local function read_json(path)
	local lines = vim.fn.readfile(path)
	return vim.json.decode(table.concat(lines, "\n"))
end

local function glob_one(pattern)
	local g = vim.fn.glob(pattern, true, true)
	if type(g) == "table" and #g > 0 then
		return g[1]
	end
	if type(g) == "string" and g ~= "" then
		return g
	end
	return nil
end

function M.introspect_target(binary_dir, target, configuration)
	binary_dir = vim.fs.normalize(binary_dir)
	local glob_expr = binary_dir .. "/.cmake/api/v1/reply/target-" .. target .. "-" .. configuration .. "-*.json"
	local idx = glob_one(glob_expr)
	if not idx then
		return nil, "No File API reply found for target " .. target .. " in configuration " .. configuration
	end
	local index = read_json(idx)
	return {
		name = index.name,
		type = index.type,
		artifacts = index.artifacts,
	}
end

function M.list_targets(binary_dir, configuration)
	binary_dir = vim.fs.normalize(binary_dir)
	local glob_expr = binary_dir .. "/.cmake/api/v1/reply/index-*.json"
	local idx = glob_one(glob_expr)
	if not idx then
		return nil, "No File API reply index found in " .. glob_expr .. " Run configure first."
	end

	local index = read_json(idx)

	-- find codemodel object
	local codemodel_path
	for _, obj in ipairs(index.objects or {}) do
		if obj.kind == "codemodel" then
			codemodel_path = binary_dir .. "/.cmake/api/v1/reply/" .. obj.jsonFile
			break
		end
	end
	if not codemodel_path then
		return nil, "No codemodel in File API index."
	end

	local codemodel = read_json(codemodel_path)

	-- Grab targets across configs/projects
	local out = {}
	local seen = {}

	for _, cfg in ipairs(codemodel.configurations) do
		for _, tgt in ipairs(cfg.targets or {}) do
			-- tgt.name is what you pass to --target
			if tgt.name and not seen[tgt.name] then
				seen[tgt.name] = true

				local target = M.introspect_target(binary_dir, tgt.name, configuration)
				if target then
					table.insert(out, target)
				end
			end
		end
	end

	return out
end

return M
