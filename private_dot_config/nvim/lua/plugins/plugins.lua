return {
    "tpope/vim-sensible", -- Sensible defaults
    {
        "echasnovski/mini.surround",
        opts = {
            mappings = {
                add = "as",
                delete = "ds", -- Delete surrounding
                replace = "cs" -- Replace surrounding
            },
        },
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
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
                { desc = 'Telescope find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep,
                { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers,
                { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags,
                { desc = 'Telescope help tags' })
        end
    }
}
