vim.opt_local.expandtab = false
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("Go", { clear = true }),
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format()
  end,
})
