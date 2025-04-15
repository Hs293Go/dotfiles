return {
	"williamboman/mason.nvim",
	dependencies = { "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim" },
	opts = {
		ensure_installed = {
			"cmakelang",
			"cmakelint",
			"stylua",
			"shfmt",
			"latexindent",
			"markdownlint-cli2",
			"prettier",
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
				"stylua",
				"shfmt",
				"markdownlint-cli2",
				"prettier",
				"rustfmt",
			},
			auto_update = true,
			run_on_start = true,
		})
	end,
}
