return {
	"tpope/vim-fugitive", -- Git integration
	{
		"lewis6991/gitsigns.nvim",
		event = "LazyFile",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
				end

				-- Navigation
				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Go to next hunk")

				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Go to previous hunk")
				map("n", "]H", function()
					gs.nav_hunk("last")
				end, "Last Hunk")
				map("n", "[H", function()
					gs.nav_hunk("first")
				end, "First Hunk")
				map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
				map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
				map("n", "<leader>ghS", gs.stage_buffer, "Stage buffer")
				map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage hunk")
				map("n", "<leader>ghR", gs.reset_buffer, "Reset buffer")
				map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview hunk inline")

				map("n", "<leader>ghb", function()
					gs.blame_line({ full = true })
				end)

				map("n", "<leader>ghB", function()
					gs.blame()
				end, "Blame Buffer")

				map("n", "<leader>ghd", gs.diffthis, "Diff this")

				map("n", "<leader>ghD", function()
					gs.diffthis("~")
				end, "Diff this ~")

				-- Toggles
				map("n", "<leader>tb", gs.toggle_current_line_blame)
				map("n", "<leader>td", gs.toggle_deleted)
				map("n", "<leader>tw", gs.toggle_word_diff, "Toggle word diff")

				-- Text object
				map({ "o", "x" }, "ih", gs.select_hunk)
			end,
		},
	},
}
