return {
	"lervag/vimtex",
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
		vim.api.nvim_set_keymap(
			"n",
			"<leader>Tcc",
			":VimtexCompile<CR>",
			{ noremap = true, silent = true, desc = "Compile LaTeX with Vimtex" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>Tcl",
			":VimtexClean<CR>",
			{ noremap = true, silent = true, desc = "Clean LaTeX with Vimtex" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>Tcv",
			":VimtexView<CR>",
			{ noremap = true, silent = true, desc = "View PDF with Vimtex" }
		)

		vim.api.nvim_set_keymap(
			"n",
			"<leader>Twc",
			":VimtexCountWords<CR>",
			{ noremap = true, silent = true, desc = "Count words with Vimtex" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>Ti",
			":VimtexInfo<CR>",
			{ noremap = true, silent = true, desc = "Vimtex Information" }
		)

		vim.api.nvim_set_keymap(
			"n",
			"<leader>Te",
			":VimtexErrors<CR>",
			{ noremap = true, silent = true, desc = "Vimtex errors" }
		)
	end,
}
