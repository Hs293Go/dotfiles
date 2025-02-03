return {
    "tpope/vim-sensible", "tpope/vim-surround", "tpope/vim-fugitive",
    'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline', "hrsh7th/nvim-cmp",
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {'nvim-tree/nvim-web-devicons'}
    }, "neovim/nvim-lspconfig", {
        'lervag/vimtex',
        config = function()
            vim.g.vimtex_view_general_viewer = 'okular'
            vim.g.vimtex_compiler_method = 'latexmk'
            vim.g.vimtex_compiler_latexmk = {
                ['build_dir'] = 'build',
                ['out_dir'] = 'build'
            }
        end
    }
}

