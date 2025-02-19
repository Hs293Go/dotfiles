vim.api.nvim_set_keymap('n', ';', ':', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', ';', ':', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '::', ';', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '::', ';', { noremap = true, silent = true })

-- increment number (plus)
vim.api.nvim_set_keymap('n', '<c-p>', '<c-a>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<c-p>', '<c-a>', { noremap = true, silent = true })
-- decrement number (minus)
vim.api.nvim_set_keymap('n', '<c-m>', '<c-x>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<c-m>', '<c-x>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', '<F9>', '<C-O>za', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F9>', 'za', { noremap = true, silent = true })
vim.api.nvim_set_keymap('o', '<F9>', '<C-C>za', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<F9>', 'zf', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bprev<CR>', { noremap = true, silent = true })


-- show spaces
vim.api.nvim_set_keymap('n', '<leader>S', ':set nolist!<CR>', { silent = true })
-- show line numbers
vim.api.nvim_set_keymap('n', '<leader>l', ':set nonu!<CR>', { silent = true })
-- wrap lines
vim.api.nvim_set_keymap('n', '<leader>w', ':set nowrap!<CR>', { silent = true })
-- hide highlight of searches
vim.api.nvim_set_keymap('n', '//', ':nohlsearch<CR>', { silent = true })

-- Remap floating terminal to <C-`> for vscode compatibility
vim.keymap.del("n", "<C-/>")
local toggle_terminal = function()
  require("snacks").terminal(nil, { cwd = require("lazyvim.util").root() })
end
vim.keymap.set("n", "<C-`>", toggle_terminal, { desc = "Terminal (Root Dir)", noremap = true, silent = true })
vim.keymap.set("t", "<C-`>", toggle_terminal, { desc = "Terminal (Root Dir)", noremap = true, silent = true })

local delete_buffer = function()
  require("snacks").bufdelete()
end

-- Remap delete buffer to <C-c>
vim.keymap.set("n", "<C-c>", delete_buffer, { desc = "Delete buffer", noremap = true, silent = true })

-- Remap gcc to <C-/> for vscode compatibility
-- https://github.com/neovim/neovim/discussions/29075
vim.keymap.set("n", "<C-/>", function()
  vim.cmd.norm('gcc')
end)

vim.keymap.set("v", "<C-/", function()
  vim.cmd.norm('gc')
end)

-- Keymaps for navigating diagnostics
vim.keymap.set('n', '<F8>', function()
  vim.diagnostic.goto_next() -- Jump to the next diagnostic
end, { desc = "Go to next diagnostic" })

vim.keymap.set('n', '<S-F8>', function()
  vim.diagnostic.goto_prev() -- Jump to the previous diagnostic
end, { desc = "Go to previous diagnostic" })
