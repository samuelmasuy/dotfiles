autocmd BufRead,BufNewFile *.Tugfile set filetype=terraform
autocmd BufRead,BufNewFile Tugfile set filetype=terraform
" autocmd FileType hcl set filetype=terraform
autocmd FileType terraform noremap <leader>r :TerraformFmt<CR>

autocmd BufRead,BufNewFile haproxy* set filetype=haproxy
autocmd FileType haproxy setlocal commentstring=#\ %s
