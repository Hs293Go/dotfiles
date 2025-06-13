return {
	-- Other plugins...
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "markdown", "cpp", "python", "lua", "vim", "bash" },
				highlight = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
}
