vim.opt.compatible = false -- disable compatibility to old-time vi
vim.opt.showmatch = true -- show matching
vim.opt.ignorecase = true -- case insensitive
vim.opt.mouse = "v" -- middle-click paste with
vim.opt.hlsearch = true -- highlight search

vim.opt.wildmenu = true
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.signcolumn = "yes"

vim.opt.relativenumber = false
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.ttyfast = true
vim.opt.swapfile = false
vim.o.foldcolumn = "1" -- '0' is not bad
vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.g.lazyvim_picker = "fzf"

vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignorecase = true
