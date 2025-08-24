return {
	{
		"williamboman/mason.nvim",
		version = "1.11.0",
		dependencies = {
			{ "williamboman/mason-lspconfig.nvim", version = "1.32.0" },
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		opts = {
			ensure_installed = {
				"cmakelang",
				"cmakelint",
				"stylua",
				"shfmt",
				"latexindent",
				"markdownlint-cli2",
				"prettier",
				"tree-sitter-cli",
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
					"pyright",
					"rust_analyzer",
					"lua_ls",
				},
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					"cmake-language-server",
					"cmakelang",
					"cmakelint",
					"tree-sitter-cli",
					{
						"stylua",
						version = "v2.0.1",
					},
					"shfmt",
					"markdownlint-cli2",
					"prettier",
					"rustfmt",
					"nixfmt",
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
			"williamboman/mason.nvim",
		},
		opts = {
			automatic_installation = true,
			ensure_installed,
			{
				"codelldb",
				"cpptools",
			},
		},
	},
}
