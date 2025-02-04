require("config.lazy")

vim.cmd('colorscheme sonokai')

vim.cmd('filetype plugin on')
vim.cmd('filetype indent on')
vim.cmd('syntax on')

vim.opt.compatible = false -- disable compatibility to old-time vi
vim.opt.showmatch = true -- show matching
vim.opt.ignorecase = true -- case insensitive
vim.opt.mouse = "v" -- middle-click paste with
vim.opt.hlsearch = true -- highlight search

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.wildmenu = true
vim.opt.wildmode = {"longest:full", "full"}
vim.opt.signcolumn = "yes"

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"cpp", "c"},
    command = "setlocal ts=2 sw=2 sts=2 expandtab"
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    command = "setlocal foldmethod=indent makeprg=python\\ %"
})

vim.opt.autoindent = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.ttyfast = true
vim.opt.swapfile = false

vim.api.nvim_set_keymap('n', ';', ':', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', ';', ':', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '::', ';', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '::', ';', {noremap = true, silent = true})

-- increment number (plus)
vim.api.nvim_set_keymap('n', '<c-p>', '<c-a>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<c-p>', '<c-a>', {noremap = true, silent = true})
-- decrement number (minus)
vim.api.nvim_set_keymap('n', '<c-m>', '<c-x>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<c-m>', '<c-x>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('i', '<F9>', '<C-O>za', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<F9>', 'za', {noremap = true, silent = true})
vim.api.nvim_set_keymap('o', '<F9>', '<C-C>za', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<F9>', 'zf', {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<C-a>', '<C-w>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-a>', '<C-w>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<Tab>', ':bnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bprev<CR>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<F5>', ':VimtexCompile<CR>', {noremap = true, silent = true})

-- show spaces
vim.api.nvim_set_keymap('n', '<leader>S', ':set nolist!<CR>', {silent = true})
-- show line numbers
vim.api.nvim_set_keymap('n', '<leader>l', ':set nonu!<CR>', {silent = true})
-- wrap lines
vim.api.nvim_set_keymap('n', '<leader>w', ':set nowrap!<CR>', {silent = true})
-- hide highlight of searches
vim.api.nvim_set_keymap('n', '//', ':nohlsearch<CR>', {silent = true})
