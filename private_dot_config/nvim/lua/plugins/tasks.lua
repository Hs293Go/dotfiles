return {
	"stevearc/overseer.nvim",
	---@module 'overseer'
	---@type overseer.SetupOpts
	opts = {},
	keys = {
		{
			"<leader>Cc",
			function()
				require("cmake_overseer.templates").configure()
			end,
			desc = "CMake Configure",
		},
		{
			"<leader>Cb",
			function()
				require("cmake_overseer.templates").build()
			end,
			desc = "CMake Build",
		},
		{
			"<leader>Ct",
			function()
				require("cmake_overseer.templates").test()
			end,
			desc = "CMake Test",
		},
		{
			"<leader>Cr",
			function()
				require("cmake_overseer.templates").launch()
			end,
			desc = "CMake Launch Target",
		},
		{
			"<leader>Csc",
			function()
				require("cmake_overseer.templates").reselect_configure()
			end,
			desc = "CMake Reselect Configure Preset",
		},
		{
			"<leader>Csb",
			function()
				require("cmake_overseer.templates").reselect_build()
			end,
			desc = "CMake Reselect Build Preset",
		},
	},
}
