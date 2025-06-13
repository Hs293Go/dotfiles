return {
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
				"jedi_language_server@0.42.0",
				"rust_analyzer",
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
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
}
