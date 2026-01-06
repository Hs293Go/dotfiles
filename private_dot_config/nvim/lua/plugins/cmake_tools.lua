return {
	"Hs293Go/cmake-tools.nvim",
	ft = { "cmake", "cmake.in", "CMakeLists.txt", "cpp", "c", "h", "hpp" },
	lazy = true,
	opts = {},
	keys = {
		{
			"<leader>Cg",
			":CMakeGenerate<CR>",
			desc = "Generate CMake project",
		},
		{
			"<leader>Cb",
			":CMakeBuild<CR>",
			desc = "Build CMake project",
		},
		{
			"<leader>Ci",
			":CMakeInstall<CR>",
			desc = "Install CMake project",
		},
		{
			"<leader>Cd",
			":CMakeDebug<CR>",
			desc = "Debug CMake target",
		},
		{
			"<leader>Cr",
			":CMakeRun<CR>",
			desc = "Run CMake target",
		},
		{
			"<leader>Cxe",
			":CMakeStopExecutor<CR>",
			desc = "Stop CMake Executor",
		},
		{
			"<leader>Cxr",
			":CMakeStopRunner<CR>",
			desc = "Stop CMake Runner",
		},
		{
			"<leader>Csc",
			":CMakeSelectConfigurePreset<CR>",
			desc = "Select CMake configure preset",
		},
		{
			"<leader>Csp",
			":CMakeSelectBuildPreset<CR>",
			desc = "Select CMake build preset",
		},
		{
			"<leader>Csb",
			":CMakeSelectBuildType<CR>",
			desc = "Select CMake build type",
		},
		{
			"<leader>Cst",
			":CMakeSelectBuildTarget<CR>",
			desc = "Select CMake build target",
		},
		{
			"<leader>Csl",
			":CMakeSelectLaunchTarget<CR>",
			desc = "Select CMake launch target",
		},
	},
	config = function()
		local cmake_tools = require("cmake-tools")
		cmake_tools.setup({
			cmake_build_directory = "build",
		})
	end,
}
