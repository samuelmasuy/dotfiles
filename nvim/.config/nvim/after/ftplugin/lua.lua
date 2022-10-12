vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 2
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("Lua", { clear = true }),
	pattern = "*.lua",
	callback = function()
		vim.lsp.buf.format()
	end,
})
