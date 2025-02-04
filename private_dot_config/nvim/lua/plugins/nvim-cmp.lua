return {
    "hrsh7th/nvim-cmp", -- Completion engine
    dependencies = {
        "hrsh7th/cmp-buffer", -- Source for buffer words
        "hrsh7th/cmp-path", -- Source for file paths
        "hrsh7th/cmp-nvim-lsp", -- Source for LSP-based completions
        "L3MON4D3/LuaSnip", -- Snippet engine
        "hrsh7th/cmp-nvim-lua", -- Source for Lua completions
        "honza/vim-snippets", -- Snippet collection
        "rafamadriz/friendly-snippets", -- Snippet collection
        "onsails/lspkind.nvim" -- Icons for completions
    },
    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end
            },
            mapping = {
                ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
                ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
                ["<Down>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then

                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, {"i", "s"}),
                ["<Up>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end),
                ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
                ["<C-y>"] = cmp.config.disable, -- Disable default `<C-y>` mapping
                ["<C-e>"] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close()
                }),
                ["<CR>"] = cmp.mapping.confirm({select = true}) -- Confirm completion
            },
            sources = cmp.config.sources({
                {name = "nvim_lsp"}, -- LSP-based completions
                {name = 'luasnip'}, -- For luasnip users.
                {name = "buffer"}, -- Buffer words
                {name = "path"}, -- File paths
                {name = 'vimtex'}

            }),
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 20,
                    ellipsis_char = "..."
                })
            }
        })

        cmp.setup.cmdline({'/', '?'}, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {{name = 'buffer'}}
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config
                .sources({{name = 'path'}}, {{name = 'cmdline'}}),
            matching = {disallow_symbol_nonprefix_matching = false}
        })
    end
}
