return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",       -- Source for buffer words
            "hrsh7th/cmp-path",         -- Source for file paths
            "hrsh7th/cmp-nvim-lsp",     -- Source for LSP-based completions
            "L3MON4D3/LuaSnip",         -- Snippet engine
            "saadparwaiz1/cmp_luasnip", -- Source for LuaSnip completions
            "onsails/lspkind.nvim"      -- Icons for completions

        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                mapping = {
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4),
                        { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4),
                        { "i", "c" }),
                    -- coc-snippets's mapping for jumping to the next snippet's placeholder
                    ["<C-j>"] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    -- coc-snippets's mapping for jumping to the previous snippet's placeholder
                    ["<C-k>"] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-y>"] = cmp.config.disable, -- Disable default `<C-y>` mapping
                    ["<C-e>"] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close()
                    }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true })
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- LSP-based completions
                    { name = 'luasnip' },  -- For luasnip users.
                    { name = "buffer" },   -- Buffer words
                    { name = "path" },     -- File paths
                    { name = 'vimtex' }
                })
            })
        end
    }, {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "rafamadriz/friendly-snippets", -- Snippet collection
        "honza/vim-snippets"            -- Snippet collection
    },
    version = "v2.*",                   -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    build = "make install_jsregexp",
    after = "nvim-cmp",
    lazy = false,
    config = function()
        -- Load snippets from friendly-snippets (vscode format)
        require('luasnip.loaders.from_vscode').lazy_load()

        -- Load snippets from vim-snippets (snipmate format)
        require('luasnip.loaders.from_snipmate').lazy_load()

        -- Optionally, load custom snippets from a directory
        require("luasnip.loaders.from_lua").load({ paths = "~/.snippets" })
    end
}
}
