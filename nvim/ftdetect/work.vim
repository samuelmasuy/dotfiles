augroup Tug
  au!
  autocmd BufRead,BufNewFile *.Tugfile set filetype=terraform
  autocmd BufRead,BufNewFile Tugfile set filetype=terraform
  autocmd BufRead,BufNewFile *.hcl set filetype=terraform
  autocmd FileType terraform noremap <leader>r :TerraformFmt<CR>
augroup END

augroup haproxy
  au!
  autocmd BufRead,BufNewFile haproxy* set filetype=haproxy
  autocmd FileType haproxy setlocal commentstring=#\ %s
augroup END
