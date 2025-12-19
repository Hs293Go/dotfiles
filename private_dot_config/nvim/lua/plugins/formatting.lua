return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			sh = { "shfmt" },
			cmake = { "cmake_format" },
			md = { "prettier" },
			tex = { "latexindent" },
			python = { "ruff", lsp_format = "prefer" },
			c = { "clang-format", lsp_format = "prefer" },
			cpp = { "clang-format", lsp_format = "prefer" },
			cuda = { "clang-format", lsp_format = "prefer" },
			toml = { "taplo" },
			json = { "prettier" },
			xml = { "xmllint" },
			yaml = { "prettier" },
			rust = { "rustfmt" },
			nix = { "nixfmt" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			html = { "prettier" },
			sql = { "pg_format" },
		},
		-- The options you set here will be merged with the builtin formatters.
		-- You can also define any custom formatters here.
		---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
		formatters = {
			["clang-format"] = {
				args = { "--fallback-style=Google" },
			},
			latexindent = {
				args = { "-g", "/dev/null", "-y", "defaultIndent:'    '" },
			},
		},
	},
	keys = {
		{
			"<leader>if",
			"<cmd>ConformInfo<cr>",
			desc = "Show conform.nvim info",
		},
	},
}
