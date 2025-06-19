return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {

		flavor = "mocha", -- best dark base for Monokai feel
		color_overrides = {
			mocha = {
				base = "#171A1B", -- deep transparent-friendly charcoal

				white = "#F8F8F2", -- near-white for high contrast text

				surface2 = "#75715E", -- brownish comments
				surface1 = "#49483E", -- subtle inactive UI
				surface0 = "#3E3D32", -- shadowed inner border

				orange = "#FD971F", -- orange accents
				red = "#F92672",
				yellow = "#E6DB74",
				green = "#A6E22E",
				blue = "#66D9EF",
				lavender = "#AE81FF",
			},
		},
		highlight_overrides = {
			mocha = function(colors)
				return {
					-- Types and classes
					["@type"] = { fg = colors.green },
					["@type.builtin"] = { fg = colors.blue },
					["@type.builtin.cpp"] = { fg = colors.blue },

					-- Make sure parameters are called out by orange
					["@parameter"] = { fg = colors.orange },
					["@variable.parameter"] = { fg = colors.orange },
					["@lsp.type.parameter"] = { fg = colors.orange },

					-- Unify keyword coloring to red
					["@keyword.all"] = { fg = colors.red },
					["@keyword.type"] = { fg = colors.red },
					["@keyword.import"] = { fg = colors.red },
					["@keyword.return"] = { fg = colors.red },
					Exception = { fg = colors.red },
					Keyword = { fg = colors.red },
					Conditional = { fg = colors.red },

					-- These are highlighted in blue by clangd. Follow suit.
					["@keyword.modifier"] = { fg = colors.blue },
					["@keyword.function"] = { fg = colors.blue },

					-- Strings, including doc comments
					String = { fg = colors.yellow },
					["@string"] = { fg = colors.yellow },

					-- All variables are white
					["@variable"] = { fg = colors.white },
					["@property"] = { fg = colors.white },
					["@lsp.type.property"] = { fg = colors.white },
					["@variable.member"] = { fg = colors.white },

					-- All numbers are lavender
					["@number"] = { fg = colors.lavender },
					["@boolean"] = { fg = colors.lavender },
					["@number.float"] = { fg = colors.lavender },
					["@string.escape"] = { fg = colors.lavender },

					-- `ErrorCode::Success` and other enum-like constants

					-- Functions (both declaration and call)
					["@function"] = { fg = colors.green },
					["@function.call"] = { fg = colors.green },
					["@function.builtin"] = { fg = colors.green },
					["@function.method"] = { fg = colors.green },
					["@module"] = { fg = colors.green },

					["@punctuation.bracket"] = { fg = colors.yellow },
					["@punctuation.delimiter"] = { fg = colors.white },
					["@punctuation.special"] = { fg = colors.red },
					["@operator"] = { fg = colors.red },

					["@lsp.type.enumMember"] = { fg = colors.white }, -- LSP semantic token

					-- Types like `Matrix3`, `Const`, etc.
					Type = { fg = colors.green },
					["@type"] = { fg = colors.green },

					-- Modules or namespace prefixes like `na::`
					["@namespace"] = { fg = colors.green },
					["@lsp.type.namespace"] = { fg = colors.green },

					-- Doc comments
					["@comment"] = { fg = colors.surface2, italic = true },
					["@comment.documentation"] = { fg = colors.yellow },
					InlayHint = { fg = colors.surface2, italic = true }, -- standard fallback
					LspInlayHint = { fg = colors.surface2, italic = true },
				}
			end,
		},
		transparent_background = true,
		integrations = {
			aerial = true,
			alpha = true,
			cmp = true,
			dashboard = true,
			flash = true,
			fzf = true,
			grug_far = true,
			gitsigns = true,
			headlines = true,
			illuminate = true,
			indent_blankline = { enabled = true },
			leap = true,
			lsp_trouble = true,
			mason = true,
			markdown = true,
			mini = true,
			native_lsp = {
				enabled = true,
				underlines = {
					errors = { "undercurl" },
					hints = { "undercurl" },
					warnings = { "undercurl" },
					information = { "undercurl" },
				},
			},
			navic = { enabled = true, custom_bg = "lualine" },
			neotest = true,
			neotree = true,
			noice = true,
			notify = true,
			semantic_tokens = true,
			snacks = true,
			telescope = true,
			treesitter = true,
			treesitter_context = true,
			which_key = true,
		},
	},
}
