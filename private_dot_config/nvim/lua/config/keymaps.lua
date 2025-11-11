vim.api.nvim_set_keymap("n", ";", ":", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ";", ":", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "::", ";", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "::", ";", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", ":bprev<CR>", { noremap = true, silent = true })

-- Remap floating terminal to <C-`> for vscode compatibility
local Term = require("snacks").terminal
local get_unique_terminal = function()
	Term.get(nil, { env = { NVIM_TERM_UID = vim.fn.sha256(os.time() .. vim.loop.hrtime()) } })
end
local toggle_all = function()
	local termlist = Term.list()
	if #termlist == 0 then
		get_unique_terminal()
		return
	end
	for _, term in pairs(termlist) do
		term:toggle()
	end
end
vim.keymap.set("n", "<C-`>", toggle_all, { desc = "Terminal (cwd)", noremap = true, silent = true })
vim.keymap.set("t", "<C-`>", toggle_all, { desc = "Terminal (cwd)", noremap = true, silent = true })

vim.keymap.set("t", "<C-S-5>", get_unique_terminal, { desc = "Create new terminal", noremap = true, silent = true })

local delete_buffer = function()
	if string.find(vim.bo.buftype, "terminal") == nil then
		require("snacks").bufdelete()
	end
end

-- Remap delete buffer to <C-c>
vim.keymap.set("n", "<C-c>", delete_buffer, { desc = "Delete buffer", noremap = true, silent = true })

vim.keymap.del("n", "<C-/>")
-- Remap gcc to <C-/> for vscode compatibility
-- https://github.com/neovim/neovim/discussions/29075
vim.keymap.set("n", "<C-/>", function()
	vim.cmd.norm("gcc")
end)

vim.keymap.set("v", "<C-/>", "gc", {
	remap = true,
})

-- Exit terminal insert mode safely
vim.keymap.set("t", "<C-q>", [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Exit terminal mode" })
