vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("Terraform", { clear = true }),
  pattern = "terraform",
  callback = function()
    vim.lsp.buf.format()
  end,
})
