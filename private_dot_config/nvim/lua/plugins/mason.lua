return {
	{
		"mason-org/mason.nvim",
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		opts = {
			ensure_installed = {
				"cmakelang",
				"cmakelint",
				"stylua",
				"shfmt",
				"latexindent",
				"prettier",
				"cmake-language-server",
				"codelldb",
			},
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"texlab",
					"cmake",
					"ruff",
					"basedpyright",
					"rust_analyzer",
					"lua_ls",
					"ts_ls",
				},
				automatic_enable = false,
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					"cmake-language-server",
					"cmakelang",
					"cmakelint",
					"stylua",
					"shfmt",
					"prettier",
					"rustfmt",
					{
						"latexindent",
						version = "V3.19.1",
					},
					"taplo",
				},
				auto_update = true,
				run_on_start = true,
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"mfussenegger/nvim-dap",
			"mason-org/mason.nvim",
		},
		opts = {
			automatic_installation = true,
			ensure_installed = {
				"codelldb",
				"cpptools",
			},
		},
	},
}
