return {
	{
		"nvim-mini/mini.surround",
		enabled = false,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		keys = {
			{
				"zR",
				function()
					require("ufo").openAllFolds()
				end,
				desc = "Open all folds (ufo)",
			},
			{
				"zM",
				function()
					require("ufo").closeAllFolds()
				end,
				desc = "Close all folds (ufo)",
			},
		},
		config = function()
			require("ufo").setup({})
		end,
	},
	{
		"ibhagwan/fzf-lua",
		keys = {
			{
				"<leader>fdb",
				function()
					local fzf = require("fzf-lua")
					local actions = require("fzf-lua").actions

					fzf.buffers({
						sort_lastused = true,
						actions = {
							["default"] = actions.buf_switch,
							["ctrl-d"] = actions.buf_del, -- delete buffer
							-- If you want "delete and stay in picker":
							-- ["ctrl-d"] = { actions.buf_del, actions.resume },
						},
					})
				end,
				desc = "View and delete Buffers",
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
