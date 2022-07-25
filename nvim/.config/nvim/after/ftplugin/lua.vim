setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2
autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
