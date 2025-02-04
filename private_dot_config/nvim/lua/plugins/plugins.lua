return {
    "tpope/vim-sensible", -- Sensible defaults
    "tpope/vim-surround", -- Surround text objects
    "tpope/vim-fugitive", -- Git integration
    "sainnhe/sonokai", -- Color scheme
    {"github/copilot.vim"}, -- GitHub Copilot integration
    {
        "williamboman/mason.nvim",
        dependencies = {"williamboman/mason-lspconfig.nvim"},
        config = function()
            require("mason").setup()
            require('mason-lspconfig').setup({
                ensure_installed = {"clangd", "texlab"}
            })
        end
    }, {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {'nvim-lua/plenary.nvim'},
        config = function()
            require('telescope').setup({
                defaults = {
                    layout_config = {
                        prompt_position = "top",
                        preview_width = 0.5
                    }
                }
            })
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files,
                           {desc = 'Telescope find files'})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep,
                           {desc = 'Telescope live grep'})
            vim.keymap.set('n', '<leader>fb', builtin.buffers,
                           {desc = 'Telescope buffers'})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags,
                           {desc = 'Telescope help tags'})
        end
    }, {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        config = function()
            local luasnip = require("luasnip")
            local cmp = require("cmp")

            cmp.setup({

                -- ... Your other configuration ...

                mapping = {

                    -- ... Your other mappings ...
                    ['<CR>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                cmp.confirm({select = true})
                            end
                        else
                            fallback()
                        end
                    end),

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, {"i", "s"}),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, {"i", "s"})

                    -- ... Your other mappings ...
                }

                -- ... Your other configuration ...
            })
        end
    }
}

