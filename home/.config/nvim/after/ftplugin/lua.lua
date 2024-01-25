vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("Lua", { clear = true }),
  pattern = "*.lua",
  callback = function()
    vim.lsp.buf.format()
  end,
})
