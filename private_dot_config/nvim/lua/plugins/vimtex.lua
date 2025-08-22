return {
	"lervag/vimtex",
	requires = {
		"folke/which-key.nvim",
	},
	ft = "tex", -- Only load for .tex files
	lazy = false,
	config = function()
		vim.g.vimtex_view_general_viewer = "okular"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk = {
			["build_dir"] = "build",
			["out_dir"] = "build",
		}
		vim.g.vimtex_complete_enabled = 1 -- Enable vimtex completions
		vim.g.vimtex_complete_close_braces = 1 -- Automatically close braces
		vim.g.vimtex_complete_ignore_case = 1 -- Ignore case in completions
		vim.g.vimtex_complete_smart_case = 1 -- Smart case sensitivity
		local wk = require("which-key")
		wk.add({
			{ "<leader>T", group = "Vimtex" },
			{
				"<leader>Tcc",
				":VimtexCompile<CR>",
				desc = "Compile LaTeX with Vimtex",
			},
			{
				"<leader>Tcl",
				":VimtexClean<CR>",
				desc = "Clean LaTeX with Vimtex",
			},
			{
				"<leader>Tcv",
				":VimtexView<CR>",
				desc = "View PDF with Vimtex",
			},
			{
				"<leader>Twc",
				":VimtexCountWords<CR>",
				desc = "Count words with Vimtex",
			},
			{
				"<leader>Ti",
				":VimtexInfo<CR>",
				desc = "Vimtex Information",
			},
			{
				"<leader>Te",
				":VimtexErrors<CR>",
				desc = "Vimtex errors",
			},
		})
	end,
}
