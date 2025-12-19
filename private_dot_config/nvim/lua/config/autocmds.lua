local lang_settings = {
	two_spaces = { "c", "cpp", "cuda", "json", "yaml", "xml", "nix", "toml", "cmake", "markdown" },
	four_spaces = { "python", "lua", "bash", "sh", "rust", "tex" },
}

local function set_tab_width(width)
	return function()
		vim.opt_local.tabstop = width
		vim.opt_local.shiftwidth = width
		vim.opt_local.softtabstop = width
		vim.opt_local.expandtab = true
	end
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = lang_settings.two_spaces,
	callback = set_tab_width(2),
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = lang_settings.four_spaces,
	callback = set_tab_width(4),
})

-- Associate tsx files with typescript filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.tsx",
	callback = function()
		vim.bo.filetype = "typescript"
	end,
})
