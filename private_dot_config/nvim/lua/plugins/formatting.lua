return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<leader>cF",
			function()
				require("conform").format({
					formatters = { "injected" },
					timeout_ms = 3000,
				})
			end,
			mode = { "n", "v" },
			desc = "Format Injected Langs",
		},
	},
	opts = {
		default_format_opts = {
			timeout_ms = 3000,
			async = false, -- not recommended to change
			quiet = false, -- not recommended to change
			lsp_format = "fallback", -- not recommended to change
			format_on_save = {
				timeout_ms = 3000,
				lsp_fallback = true,
			},
		},
		formatters_by_ft = {
			lua = { "stylua" },
			sh = { "shfmt" },
			cmake = { "cmake_format" },
			md = { "prettier" },
			tex = { "latexindent" },
			python = { "black", lsp_format = "prefer" },
			c = { "clang-format", lsp_format = "prefer" },
			cpp = { "clang-format", lsp_format = "prefer" },
			toml = { "taplo" },
			json = { "prettier" },
			xml = { "xmllint" },
			yaml = { "prettier" },
			rust = { "rustfmt" },
		},
		-- The options you set here will be merged with the builtin formatters.
		-- You can also define any custom formatters here.
		---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
		formatters = {
			injected = {
				options = {
					ignore_errors = true,
				},
			},
			latexindent = {
				args = { "-g", "/dev/null" },
			},
		},
	},
}
