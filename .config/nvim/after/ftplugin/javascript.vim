setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2

setlocal commentstring=//\ %s
autocmd BufLeave *.js             normal! mJ

" augroup MyJavascriptCommands
"   au!
"   autocmd BufWritePost *.js :silent! Prettier
" augroup END

let b:javascript_fold = 0
let javascript_enable_domhtmlcss=1
