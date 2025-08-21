vim.api.nvim_set_keymap("n", ";", ":", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ";", ":", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "::", ";", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "::", ";", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", ":bprev<CR>", { noremap = true, silent = true })

-- Remap floating terminal to <C-`> for vscode compatibility
local toggle_floating_terminal = function()
	require("snacks").terminal.toggle()
end
vim.keymap.set("n", "<C-`>", toggle_floating_terminal, { desc = "Terminal (cwd)", noremap = true, silent = true })
vim.keymap.set("t", "<C-`>", toggle_floating_terminal, { desc = "Terminal (cwd)", noremap = true, silent = true })
vim.keymap.set("t", "<C-S-5>", function()
	require("snacks").terminal.open()
end, { desc = "Create new terminal", noremap = true, silent = true })

local delete_buffer = function()
	require("snacks").bufdelete()
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
