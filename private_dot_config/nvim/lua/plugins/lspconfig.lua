return {

    "neovim/nvim-lspconfig", -- LSP configuration
    config = function()
        local lspconfig = require("lspconfig")

        lspconfig.clangd.setup {
            cmd = {
                'clangd', '--background-index', '--clang-tidy', '--log=verbose'
            },
            init_options = {fallbackFlags = {'-std=c++17'}}
        }

        lspconfig.texlab.setup({
            settings = {
                texlab = {
                    build = {onSave = true},
                    diagnostics = {enabled = true}
                }
            }
        })
    end
}
