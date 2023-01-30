local M = {}

function M.LspHide()
	if #vim.lsp.buf_get_clients() > 0 then
		vim.b.lsp_shown = 0
		vim.diagnostic.hide()
		print("Diagnostic Disabled.")
	else
		error("Diagnostic not enabled in this buffer.")
	end
end

function M.LspShow()
	if #vim.lsp.buf_get_clients() > 0 then
		vim.b.lsp_shown = 1
		vim.diagnostic.show()
		print("Diagnostic Enabled.")
	else
		error("Diagnostic not enabled in this buffer.")
	end
end

function M.LspSwap()
	if vim.b.lsp_shown == 0 then
		M.LspShow()
	else
		M.LspHide()
	end
end

return M
