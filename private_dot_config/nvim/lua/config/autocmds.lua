vim.api.nvim_create_autocmd("FileType", {
	pattern = { "cpp", "c", "cuda", "json", "xml", "nix", "toml" },
	command = "setlocal ts=2 sw=2 sts=2 expandtab",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python", "lua", "sh", "rust", "yaml" },
	command = "setlocal ts=4 sw=4 sts=4 expandtab",
})
