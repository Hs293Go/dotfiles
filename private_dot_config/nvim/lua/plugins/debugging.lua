return {
	-- Core DAP
	{
		"mfussenegger/nvim-dap",

		config = function()
			local dap = require("dap")
			local utils = require("dap.utils")
			vim.keymap.set("n", "<F5>", dap.continue)
			vim.keymap.set("n", "<S-F5>", dap.terminate)
			vim.keymap.set("n", "<F10>", dap.step_over)
			vim.keymap.set("n", "<F11>", dap.step_into)
			vim.keymap.set("n", "<F12>", dap.step_out)
			vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dr", dap.repl.open)
			vim.keymap.set("n", "<leader>dsp", utils.pick_process, { desc = "Pick Process" })
			vim.keymap.set("n", "<leader>dsf", utils.pick_file, { desc = "Pick File" })
		end,
	},
	-- UI panels
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("dapui").setup({})
			local dap = require("dap")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				require("dapui").open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				require("dapui").close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				require("dapui").close()
			end

			require("dap").configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch file",
					program = "${file}", -- current file
					pythonPath = function()
						return vim.fn.exepath("python3")
					end,
				},
			}
			vim.keymap.set("n", "<leader>du", require("dapui").toggle)
		end,
	},
	-- Mason integration
	{
		"mfussenegger/nvim-dap-python",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dap-python").setup("python")
			require("dap-python").setup("uv")
		end,
	},
}
