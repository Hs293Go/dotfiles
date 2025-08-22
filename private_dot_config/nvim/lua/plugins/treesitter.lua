return {
	-- Other plugins...
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					-- systems languages
					"c",
					"cpp",
					"cuda",
					"rust",

					-- scripting languages
					"python",
					"lua",
					"vim",

					-- OS/system/build scripting
					"bash",
					"nix",
					"make",
					"cmake",
					"dockerfile",

					-- markup languages
					"latex",
					"markdown",

					-- config languages
					"toml",
					"xml",
					"json",
					"yaml",

					-- version control
					"gitignore",
					"diff",
				},
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
