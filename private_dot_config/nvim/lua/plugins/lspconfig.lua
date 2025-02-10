return {

    "neovim/nvim-lspconfig", -- LSP configuration
    config = function()
        local lspconfig = require("lspconfig")
        local on_attach = function(client, bufnr)
            local function make_opts(desc)
                return { noremap = true, silent = true, buffer = bufnr, desc = desc }
            end

            local function filter_actions(key)
                return function(action)
                    for _, k in ipairs(key) do
                        if action.title:lower():match(k) then
                            return true
                        end
                    end
                end
            end

            -- Other LSP keymaps can be added here
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ async = false })
                    end,
                })
            end

            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.py" }, -- Adjust file types as needed
                callback = function()
                    -- Trigger the "organize imports" code action
                    vim.lsp.buf.code_action({
                        apply = true, -- Apply the action immediately
                        filter = filter_actions { "organize imports" },
                        context = {
                            only = { "source.organizeImports" }, -- Only organize imports actions
                        },
                    })
                end,
            })

            vim.keymap.set("n", "<F12>", vim.lsp.buf.definition, make_opts("Go to definition"))
            vim.keymap.set("n", "<M-S-F12>", vim.lsp.buf.type_definition, make_opts("Go to type definition"))
            vim.keymap.set("n", "<C-S-F12>", vim.lsp.buf.implementation, make_opts("Go to implementation"))
            vim.keymap.set("n", "<S-F12>", vim.lsp.buf.references, make_opts("Find references"))
            vim.keymap.set("n", "K", vim.lsp.buf.hover, make_opts("Show hover information"))
            vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, make_opts("Rename variable"))
            vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, make_opts("Format document"))
            vim.keymap.set("v", "<leader>f", vim.lsp.buf.format, make_opts("Format selection"))
            vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, make_opts("Show code actions"))
            vim.keymap.set("v", "<C-.>", vim.lsp.buf.code_action, make_opts("Show code actions on selection"))
            vim.api.nvim_create_autocmd("CursorHold", { callback = vim.lsp.buf.document_highlight })

            -- Statusline integration
            vim.opt.statusline:append("%{luaeval('vim.lsp.status()')}")

            -- Keybindings for switchSourceHeader
            vim.keymap.set("n", "<leader>O", "<cmd>ClangdSwitchSourceHeader<cr>",
                { buffer = bufnr, desc = "Switch source/header" })
            vim.keymap.set("n", "<leader>V", function()
                vim.cmd "ClangdSwitchSourceHeader"
                vim.cmd "vsplit" -- Open in a vertical split
            end, { buffer = bufnr, desc = "Switch source/header (vsplit)" })
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
