vim.api.nvim_create_autocmd("FileType", {
	pattern = { "cpp", "c" },
	command = "setlocal ts=2 sw=2 sts=2 expandtab",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "tex",
	callback = function()
		vim.api.nvim_set_keymap("n", "<F5>", ":VimtexCompile<CR>", { noremap = true, silent = true })
	end,
})
