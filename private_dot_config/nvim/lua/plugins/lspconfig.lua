return {

    "neovim/nvim-lspconfig", -- LSP configuration
    config = function()
        local lspconfig = require("lspconfig")
        local on_attach = function(client, bufnr)
            -- Keymaps for diagnostics navigation
            vim.keymap.set('n', '<F8>', function()
                vim.diagnostic.goto_next()
            end, { buffer = bufnr, desc = "Go to next diagnostic" })

            vim.keymap.set('n', '<S-F8>', function()
                vim.diagnostic.goto_prev()
            end, { buffer = bufnr, desc = "Go to previous diagnostic" })

            -- Other LSP keymaps can be added here
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ async = false })
                    end,
                })
            end
        end

        lspconfig.clangd.setup {
            cmd = {
                'clangd',                  --
                '--background-index',      -- Enable background indexing
                '--clang-tidy',            -- Enable clang-tidy
                '--header-insertion=never' -- Disable header insertion
            },
            init_options = { fallbackFlags = { '-std=c++17' } },
            on_attach = on_attach
        }

        lspconfig.pyright.setup {
            on_attach = on_attach
        }


        lspconfig.texlab.setup {
            settings = {
                texlab = {
                    build = {
                        executable = "", -- Disable the build command
                        args = {},
                        forwardSearchAfter = false,
                        onSave = false -- Prevent texlab from triggering builds
                    },
                    diagnostics = { enabled = true },
                    chktex = {
                        onOpenAndSave = true, -- Run chktex on open and save
                        onEdit = true         -- Run chktex while editing
                    }
                }
            },
            on_attach = on_attach
        }
    end
}
