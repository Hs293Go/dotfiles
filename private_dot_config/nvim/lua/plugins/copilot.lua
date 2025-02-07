return {
    "zbirenbaum/copilot.lua",
    config = function()
        require('copilot').setup {
            suggestion = {
                enabled = true,
                auto_trigger = true,
                hide_during_completion = false,
                keymap = {
                    accept = "<Right>",
                    accept_word = "<S-Right>",
                    accept_line = "<C-S-Right>",
                    next = "<C-Right>",
                    prev = "<C-Left>"
                }
            },
            filetypes = {
                tex = true
            },
        }
    end
} -- GitHub Copilot integration
