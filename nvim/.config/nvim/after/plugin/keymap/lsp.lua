local nnoremap = require("sam.keymap").nnoremap

nnoremap("<space>d", require("sam.lsp").LspSwap)
