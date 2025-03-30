return {
	"Civitasv/cmake-tools.nvim",
	config = function()
		local cmake_tools = require("cmake-tools")
		cmake_tools.setup({
			opts = {
				cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
			},
		})
		vim.api.nvim_set_keymap("n", "<F7>", ":CMakeBuild<CR>", {
			noremap = true,
			silent = true,
		})

		vim.api.nvim_set_keymap("n", "<leader>Cg", ":CMakeBuild<CR>", {
			desc = "Generate CMake project",
			noremap = true,
			silent = true,
		})

		vim.api.nvim_set_keymap("n", "<leader>Cb", ":CMakeBuild<CR>", {
			desc = "Build CMake project",
			noremap = true,
			silent = true,
		})

		vim.api.nvim_set_keymap("n", "<leader>Ci", ":CMakeInstall<CR>", {
			desc = "Install CMake project",
			noremap = true,
			silent = true,
		})

		vim.api.nvim_set_keymap("n", "<leader>Cx", ":CMakeStopExecutor<CR>", {
			desc = "Stop CMake Executor",
			noremap = true,
			silent = true,
		})

		vim.api.nvim_set_keymap("n", "<leader>Csc", ":CMakeSelectBuildPreset<CR>", {
			desc = "Select CMake configure preset",
			noremap = true,
			silent = true,
		})

		vim.api.nvim_set_keymap("n", "<leader>Csp", ":CMakeSelectBuildPreset<CR>", {
			desc = "Select CMake build preset",
			noremap = true,
			silent = true,
		})

		vim.api.nvim_set_keymap("n", "<leader>Csb", ":CMakeSelectBuildType<CR>", {
			desc = "Select CMake build type",
			noremap = true,
			silent = true,
		})
	end,
}
