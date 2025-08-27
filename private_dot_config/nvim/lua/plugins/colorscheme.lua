return {
	"folke/tokyonight.nvim",
	priority = 1000,
	opts = {
		transparent = true,
		styles = {
			sidebars = "transparent",
			floats = "transparent",
		},
		on_colors = function(colors)
			-- Backgrounds / UI
			colors.bg = "#171A1B" -- editor.background
			colors.bg_dark = "#1e1f1c" -- editorGroupHeader.tabsBackground
			colors.bg_dark1 = "#34352f" -- tab.inactiveBackground
			colors.bg_highlight = "#3e3d32" -- editor.lineHighlightBackground
			-- Foregrounds
			colors.fg = "#f8f8f2" -- editor.foreground
			colors.fg_dark = "#ccccc7" -- tab.inactiveForeground
			colors.fg_gutter = "#90908a" -- editorLineNumber.foreground
			colors.comment = "#88846f" -- comment

			-- Core palette
			colors.red = "#f92672" -- keyword/storage
			colors.red1 = "#C4265E" -- terminal.ansiRed
			colors.orange = "#FD971F" -- variable.parameter / markup.inline.raw
			colors.yellow = "#E6DB74" -- strings
			colors.green = "#A6E22E" -- functions classes
			colors.green1 = "#86B42B" -- terminal.ansiGreen
			colors.cyan = "#66D9EF" -- storage.type library functions
			colors.blue = "#819aff" -- terminal.ansiBrightBlue
			colors.blue1 = "#6A7EC8" -- terminal.ansiBlue
			colors.magenta = "#AE81FF" -- numbers/constants
			colors.magenta2 = "#8C6BC8" -- terminal.ansiMagenta
			colors.purple = "#b267e6" -- debug tokens
			colors.teal = "#56ADBC" -- terminal.ansiCyan

			-- Extra tones
			colors.dark3 = "#545c7e" -- filler (unused fallback)
			colors.dark5 = "#75715E" -- panelTitle.inactiveForeground
			colors.terminal_black = "#171A1B" -- terminal.ansiBlack
			colors.git.add = "#81b88b"
			colors.git.change = "#e2c08d"
			colors.git.delete = "#c74e39"
		end,
		on_highlights = function(hl, c)
			hl.Normal = { fg = c.fg, bg = c.bg }
			hl.NormalFloat = { fg = c.fg, bg = c.bg_dark }
			hl.FloatBorder = { fg = c.dark5, bg = c.bg_dark }
			hl.Cursor = { fg = c.bg, bg = c.fg }
			hl.CursorLine = { bg = c.bg_highlight }
			hl.CursorColumn = { bg = c.bg_highlight }
			hl.ColorColumn = { bg = c.bg_highlight }
			hl.MatchParen = { fg = c.orange, bold = true }
			hl.Search = { bg = c.yellow, fg = c.bg_dark1 }
			hl.IncSearch = { bg = c.orange, fg = c.bg_dark1 }
			hl.LineNr = { fg = c.fg_gutter }
			-- hl.CursorLineNr = { fg = "#c2c2bf" } -- editorLineNumber.activeForeground
			hl.SignColumn = { bg = c.bg }
			hl.VertSplit = { fg = c.bg_dark1 }
			hl.EndOfBuffer = { fg = c.bg }

			-- Comments / whitespace
			hl.Comment = { fg = c.comment, italic = true }
			hl.Whitespace = { fg = "#464741" } -- editorWhitespace.foreground
			hl.NonText = { fg = "#464741" }

			-- Syntax (classic Vim groups)
			hl.String = { fg = c.yellow }
			hl.Character = { fg = c.yellow }
			hl.Number = { fg = c.magenta }
			hl.Boolean = { fg = c.magenta }
			hl.Float = { fg = c.magenta }

			hl.Identifier = { fg = c.fg }
			hl.Function = { fg = c.green } -- Monokai: function/class green
			hl.Statement = { fg = c.red } -- general statements
			hl.Conditional = { fg = c.red, bold = true }
			hl.Repeat = { fg = c.red }
			hl.Label = { fg = c.orange }
			hl.Operator = { fg = c.fg }
			hl.Keyword = { fg = c.red } -- Monokai keywords pink
			hl.Exception = { fg = c.red1 }

			hl.PreProc = { fg = c.cyan }
			hl.Include = { fg = c.red }
			hl.Define = { fg = c.cyan }
			hl.Macro = { fg = c.cyan }
			hl.PreCondit = { fg = c.cyan }

			hl.Type = { fg = c.green }
			hl.StorageClass = { fg = c.red } -- “storage” in Monokai is pink
			hl.Structure = { fg = c.green }
			hl.Typedef = { fg = c.green }
			hl.Directory = { fg = c.green }

			hl.Special = { fg = c.green }
			hl.SpecialChar = { fg = c.orange }
			hl.Tag = { fg = c.red }
			hl.Delimiter = { fg = c.fg }
			hl.SpecialComment = { fg = c.comment, italic = true }
			hl.Debug = { fg = c.purple }

			hl.Underlined = { underline = true }
			hl.Bold = { bold = true }
			hl.Italic = { italic = true }

			hl.Todo = { fg = c.bg, bg = c.orange, bold = true }
			hl.Error = { fg = "#F44747" } -- invalid tokens in Monokai
			hl.WarningMsg = { fg = c.orange }
			hl.MoreMsg = { fg = c.green }
			hl.ModeMsg = { fg = c.green }

			-- Diagnostics (LSP)
			hl.DiagnosticError = { fg = "#F44747" }
			hl.DiagnosticWarn = { fg = c.orange }
			hl.DiagnosticInfo = { fg = c.cyan }
			hl.DiagnosticHint = { fg = c.teal }
			hl.DiagnosticUnderlineError = { undercurl = true, sp = "#F44747" }
			hl.DiagnosticUnderlineWarn = { undercurl = true, sp = c.orange }
			hl.DiagnosticUnderlineInfo = { undercurl = true, sp = c.cyan }
			hl.DiagnosticUnderlineHint = { undercurl = true, sp = c.teal }

			-- Diff / VCS
			hl.DiffAdd = { fg = c.git.add }
			hl.DiffChange = { fg = c.git.change }
			hl.DiffDelete = { fg = c.git.delete }
			hl.DiffText = { fg = c.yellow, bold = true }

			-- GitSigns (if used)
			hl.GitSignsAdd = { fg = c.git.add }
			hl.GitSignsChange = { fg = c.git.change }
			hl.GitSignsDelete = { fg = c.git.delete }

			-- Treesitter (basic mapping to keep the Monokai feel)
			hl["@comment"] = hl.Comment
			hl["@string"] = hl.String
			hl["@character"] = hl.Character
			hl["@number"] = hl.Number
			hl["@boolean"] = hl.Boolean
			hl["@float"] = hl.Float
			hl["@constant"] = { fg = c.magenta }
			hl["@constructor"] = { fg = c.cyan }
			hl["@constant.builtin"] = { fg = c.magenta }
			hl["@variable"] = { fg = c.fg }
			hl["@variable.builtin"] = { fg = c.orange }
			hl["@variable.parameter"] = { fg = c.orange }
			hl["@variable.member"] = { fg = c.white }
			hl["@function"] = hl.Function
			hl["@function.builtin"] = { fg = c.cyan }
			hl["@parameter"] = { fg = c.orange, italic = true }
			hl["@property"] = { fg = c.cyan, italic = true }
			hl["@keyword"] = hl.Keyword
			hl["@keyword.function"] = hl.Keyword
			hl["@type"] = hl.Type
			hl["@type.builtin"] = { fg = c.cyan, italic = true }
			hl["@tag"] = hl.Tag
			hl["@tag.attribute"] = { fg = c.green }
			hl["@tag.delimiter"] = hl.Delimiter
		end,
	},
}
