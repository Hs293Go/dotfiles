require("config.lazy")

vim.opt.compatible = false -- disable compatibility to old-time vi
vim.opt.showmatch = true -- show matching
vim.opt.ignorecase = true -- case insensitive
vim.opt.mouse = "v" -- middle-click paste with
vim.opt.hlsearch = true -- highlight search

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

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

vim.api.nvim_set_keymap('n', '<Tab>', ':bnext<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bprev<CR>',
                        {noremap = true, silent = true})

require('lualine').setup {
    options = {
        theme = "molokai",
        icons_enabled = true,
        component_separators = {left = '', right = ''},
        section_separators = {left = '', right = ''},
        disabled_filetypes = {statusline = {}, winbar = {}},
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {statusline = 100, tabline = 100, winbar = 100}
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

local lspconfig = require('lspconfig')
lspconfig.clangd.setup {
    cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose'},
    init_options = {fallbackFlags = {'-std=c++17'}}
}

vim.api.nvim_set_keymap('n', '<F5>', ':VimtexCompile<CR>',
                        {noremap = true, silent = true})

-- Set up nvim-cmp.
local cmp = require 'cmp'

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

            -- For `mini.snippets` users:
            -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
            -- insert({ body = args.body }) -- Insert at cursor
            -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
            -- require("cmp.config").set_onetime({ sources = {} })
        end
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        {name = 'nvim_lsp'}, {name = 'vsnip'} -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {{name = 'buffer'}})
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]] --

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({'/', '?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{name = 'buffer'}}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}}),
    matching = {disallow_symbol_nonprefix_matching = false}
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.

