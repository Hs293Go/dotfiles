return {
    'Civitasv/cmake-tools.nvim',
    config = function()
        local cmake_tools = require("cmake-tools")
        cmake_tools.setup {
            opts = {
                cmake_generate_options = {"-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1"}
            }

        }
        vim.api.nvim_set_keymap('n', '<F7>', ':CMakeBuild<CR>', {
            noremap = true,
            silent = true
        })
    end

}
