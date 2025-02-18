return {
  'Civitasv/cmake-tools.nvim',
  config = function()
    local cmake_tools = require("cmake-tools")
    cmake_tools.setup {}

    vim.api.nvim_set_keymap('n', '<F7>', ':CMakeBuild<CR>', { noremap = true, silent = true })
  end,

}
