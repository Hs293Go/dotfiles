return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			sh = { "shfmt" },
			cmake = { "cmake_format" },
			md = { "prettier" },
			tex = { "latexindent" },
			python = { "black", lsp_format = "prefer" },
			c = { "clang-format", lsp_format = "prefer" },
			cpp = { "clang-format", lsp_format = "prefer" },
			cuda = { "clang-format", lsp_format = "prefer" },
			toml = { "taplo" },
			json = { "prettier" },
			xml = { "xmllint" },
			yaml = { "prettier" },
			rust = { "rustfmt" },
			nix = { "nixfmt" },
		},
		-- The options you set here will be merged with the builtin formatters.
		-- You can also define any custom formatters here.
		---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
		formatters = {
			["clang-format"] = {
				args = { "--fallback-style=Google" },
			},
			latexindent = {
				args = { "-g", "/dev/null" },
			},
		},
	},
	keys = {
		{
			"<C-S-I>",
			function()
				require("conform").format({ async = true })
			end,
			desc = "Format file",
		},
	},
}
