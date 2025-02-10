vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cpp", "c" },
  command = "setlocal ts=2 sw=2 sts=2 expandtab"
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  command = "setlocal foldmethod=indent makeprg=python\\ %"
})
