return {
    "sainnhe/sonokai",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        vim.g.sonokai_style = 'espresso'
        vim.g.sonokai_better_performance = 1
        vim.g.sonokai_transparent_background = 1
    end
}
