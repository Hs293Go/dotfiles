return {
	"Civitasv/cmake-tools.nvim",
	lazy = true,
	opts = {},
	config = function()
		local cmake_tools = require("cmake-tools")
		cmake_tools.setup({
			cmake_build_directory = "build",
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

		vim.api.nvim_set_keymap("n", "<leader>Cd", ":CMakeDebug<CR>", {
			desc = "Debug CMake target",
			noremap = true,
			silent = true,
		})

		vim.api.nvim_set_keymap("n", "<leader>Cr", ":CMakeRun<CR>", {
			desc = "Run CMake target",
			noremap = true,
			silent = true,
		})

		vim.api.nvim_set_keymap("n", "<leader>Cxe", ":CMakeStopExecutor<CR>", {
			desc = "Stop CMake Executor",
			noremap = true,
			silent = true,
		})
		vim.api.nvim_set_keymap("n", "<leader>Cxr", ":CMakeStopRunner<CR>", {
			desc = "Stop CMake Runner",
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

		vim.api.nvim_set_keymap("n", "<leader>Cst", ":CMakeSelectBuildTarget<CR>", {
			desc = "Select CMake build target",
			noremap = true,
			silent = true,
		})

		vim.api.nvim_set_keymap("n", "<leader>Csl", ":CMakeSelectLaunchTarget<CR>", {
			desc = "Select CMake launch target",
			noremap = true,
			silent = true,
		})
	end,
}
