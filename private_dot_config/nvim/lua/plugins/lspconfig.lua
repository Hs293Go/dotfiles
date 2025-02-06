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
            local opts = { noremap = true, silent = true, buffer = bufnr }

            -- Go to Definition (F12)
            vim.keymap.set("n", "<F12>", vim.lsp.buf.definition, opts)

            -- Go to Declaration (Shift + F12)
            vim.keymap.set("n", "<S-F12>", vim.lsp.buf.declaration, opts)

            -- Go to Implementations (Ctrl + F12)
            vim.keymap.set("n", "<C-F12>", vim.lsp.buf.implementation, opts)

            -- Find References (Alt + F12)
            vim.keymap.set("n", "<A-F12>", vim.lsp.buf.references, opts)
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.offsetEncoding = { "utf-16" }
        lspconfig.clangd.setup {
            cmd = {
                'clangd',                  --
                '--background-index',      -- Enable background indexing
                '--clang-tidy',            -- Enable clang-tidy
                '--header-insertion=never' -- Disable header insertion
            },
            init_options = { fallbackFlags = { '-std=c++17' } },
            on_attach = on_attach,
            capabilities = capabilities
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
