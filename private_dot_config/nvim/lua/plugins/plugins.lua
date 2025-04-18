return {
	{
		"echasnovski/mini.surround",
		disable = true,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
        -- stylua: ignore
        keys = {
            { "s" , mode = { "n", "x", "o" }, false }, -- https://www.reddit.com/r/neovim/comments/177qsem/disable_flashnvim_default_mapping_in_lazyvim/
            { "S" , mode = { "n", "x", "o" }, false },
            { "gs", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "gS", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
	},
}
