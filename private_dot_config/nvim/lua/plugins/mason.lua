return {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  config = function()
    require("mason").setup()
    require('mason-lspconfig').setup({
      ensure_installed = { "clangd", "texlab", "pylsp", "cmake" },
      automatic_installation = true,
    })
  end
}
