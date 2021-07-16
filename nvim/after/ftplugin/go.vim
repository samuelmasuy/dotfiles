setlocal noexpandtab
setlocal tabstop=4
setlocal shiftwidth=4
" let g:go_highlight_build_constraints = 1
" " let g:go_highlight_methods = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_structs = 1

" let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_generate_tags = 1

" let g:go_highlight_space_tab_error = 0
" let g:go_highlight_array_whitespace_error = 0
" let g:go_highlight_trailing_whitespace_error = 0

" let g:go_auto_type_info = 1
" " let g:go_auto_sameids = 1

" let g:go_addtags_transform = "snakecase"
" let g:go_autodetect_gopath = 1
" let g:go_fmt_fail_silently = 0
" let g:go_fmt_command = "goimports"
" let g:go_metalinter_command='golangci-lint'
" " let g:go_def_mode = 'gopls'

" autocmd BufLeave *.go             normal! mG

" augroup go
"   autocmd!
"   " :GoBuild and :GoTestCompile
"   " autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
"   autocmd FileType go nmap <leader>b <Plug>(go-build)
"   " :GoTest
"   " autocmd FileType go nmap <leader>t  <Plug>(go-test)
"   " :GoRun
"   " autocmd FileType go nmap <leader>r  <Plug>(go-run)
"   " :GoInfo
"   " autocmd FileType go nmap <Leader>i <Plug>(go-info)
"   " :GoReferers
"   autocmd FileType go nmap <Leader>r <Plug>(go-referers)
"   " :GoMetaLinter
"   " autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)
"   " :GoDef
"   autocmd FileType go nmap gd <Plug>(go-def)
"   " :GoDescribe
"   autocmd FileType go nmap <leader>de <Plug>(go-describe)
"   " :GoRename
"   " autocmd FileType go nmap <leader>re <Plug>(go-rename)
"   " :GoCoverageToggle
"   autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
"   " :GoAlternate  commands :A, :AV, :AS and :AT
"   autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
"   autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
"   autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
" augroup END

" let g:go_def_mapping_enabled = 0

" " build_go_files is a custom function that builds or compiles the test file.
" " It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
" " function! s:build_go_files()
" "   let l:file = expand('%')
" "   if l:file =~# '^\f\+_test\.go$'
" "     call go#test#Test(0, 1)
" "   elseif l:file =~# '^\f\+\.go$'
" "     call go#cmd#Build(0)
" "   endif
" " endfunction
" " --concurrency=3
