return {
	{
		"catppuccin/nvim",
		opts = {
			flavor = "mocha",
			transparent_background = true,
			integrations = {
				blink_cmp = true,
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			icons_enabled = true,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			tabline = {
				lualine_a = {
					{
						"tabs",
						max_length = 88, -- follow black's rationale on reasonable width
						mode = 2, -- mode=2 shows tab names if set
					},
				},
				lualine_z = {}, -- keep it clean (optional)
			},
		},
	},
	{
		"folke/snacks.nvim",
		opts = {
			explorer = {
				enabled = false,
				replace_netrw = false,
			},
			dashboard = {
				preset = {
					header = [[
███╗   ██╗██╗   ██╗ █████╗  █████╗  ██████╗ ██╗   ██╗██╗███╗   ███╗      
████╗  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗██╔═══██╗██║   ██║██║████╗ ████║ /\ /\
██╔██╗ ██║ ╚████╔╝ ███████║███████║██║   ██║██║   ██║██║██╔████╔██║ =o o=
██║╚██╗██║  ╚██╔╝  ██╔══██║██╔══██║██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ \_Y_/
██║ ╚████║   ██║   ██║  ██║██║  ██║╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║      
╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝      
]],
				},
			},
			terminal = {
				win = {
					wo = {
						winbar = "",
					},
				},
			},
		},
	},
}
