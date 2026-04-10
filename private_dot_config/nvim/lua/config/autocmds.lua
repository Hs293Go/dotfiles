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

vim.filetype.add({
	extension = {
		tsx = "typescriptreact",
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python" },
	callback = function()
		vim.opt_local.textwidth = 88
		vim.opt_local.formatoptions:remove({ "t", "c" })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "rust" },
	callback = function()
		vim.opt_local.textwidth = 100
		vim.opt_local.formatoptions:remove({ "t", "c" })
	end,
})

vim.api.nvim_create_autocmd("Filetype", {
	pattern = { "snacks_terminal" },
	callback = function(ev)
		-- Defer so claudecode.nvim has time to register the terminal
		vim.defer_fn(function()
			if not vim.api.nvim_buf_is_valid(ev.buf) then
				return
			end
			local ok, claude_code = pcall(require, "claudecode.terminal")
			if not ok then
				return
			end
			if ev.buf ~= claude_code.get_active_terminal_bufnr() then
				return
			end
			local warn = function()
				vim.notify("Do not attempt to use ':' in the terminal buffer.")
			end
			-- Block n-mode ; (mapped globally to :) and : directly
			vim.keymap.set("n", ";", warn, { buffer = ev.buf })
			vim.keymap.set("n", ":", warn, { buffer = ev.buf })
		end, 100)
	end,
})
