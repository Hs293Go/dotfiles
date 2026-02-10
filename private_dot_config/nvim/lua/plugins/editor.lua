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
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		lazy = false,
		keys = {
			{
				"<leader>re",
				function()
					return require("refactoring").refactor("Extract Function")
				end,
				mode = { "n", "x" },
				expr = true,
				desc = "Refactor: Extract Function",
			},
			{
				"<leader>rf",
				function()
					return require("refactoring").refactor("Extract Function To File")
				end,
				mode = { "n", "x" },
				expr = true,
				desc = "Refactor: Extract Function To File",
			},
			{
				"<leader>rv",
				function()
					return require("refactoring").refactor("Extract Variable")
				end,
				mode = { "n", "x" },
				expr = true,
				desc = "Refactor: Extract Variable",
			},
			{
				"<leader>rI",
				function()
					return require("refactoring").refactor("Inline Function")
				end,
				mode = { "n", "x" },
				expr = true,
				desc = "Refactor: Inline Function",
			},
			{
				"<leader>ri",
				function()
					return require("refactoring").refactor("Inline Variable")
				end,
				mode = { "n", "x" },
				expr = true,
				desc = "Refactor: Inline Variable",
			},
			{
				"<leader>rbb",
				function()
					return require("refactoring").refactor("Extract Block")
				end,
				mode = { "n", "x" },
				expr = true,
				desc = "Refactor: Extract Block",
			},
			{
				"<leader>rbf",
				function()
					return require("refactoring").refactor("Extract Block To File")
				end,
				mode = { "n", "x" },
				expr = true,
				desc = "Refactor: Extract Block To File",
			},
		},
		opts = {
			prompt_func_return_type = {
				go = false,
				java = false,

				cpp = false,
				c = false,
				h = false,
				hpp = false,
				cxx = false,
			},
			prompt_func_param_type = {
				go = false,
				java = false,

				cpp = false,
				c = false,
				h = false,
				hpp = false,
				cxx = false,
			},
			printf_statements = {},
			print_var_statements = {},
			show_success_message = false,
		},
	},
}
