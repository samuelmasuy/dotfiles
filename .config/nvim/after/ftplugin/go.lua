vim.opt_local.expandtab = false
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("Go", { clear = true }),
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format()
  end,
})
-- [[ autocmd BufWritePre <buffer> go vim.lsp.buf.format() ]]
-- vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)

--require('go').setup{
--  go='go', -- go command, can be go[default] or go1.18beta1
--  goimport='gopls', -- goimport command, can be gopls[default] or goimport
--  fillstruct = 'gopls', -- can be nil (use fillstruct, slower) and gopls
--  gofmt = 'gofumpt', --gofmt cmd,
--  max_line_len = 120, -- max line length in goline format
--  tag_transform = false, -- tag_transfer  check gomodifytags for details
--  test_template = '', -- g:go_nvim_tests_template  check gotests for details
--  test_template_dir = '', -- default to nil if not set; g:go_nvim_tests_template_dir  check gotests for details
--  comment_placeholder = '' ,  -- comment_placeholder your cool placeholder e.g. ﳑ       
--  icons = {breakpoint = '🧘', currentpos = '🏃'},
--  verbose = false,  -- output loginf in messages
--  lsp_cfg = false, -- true: use non-default gopls setup specified in go/lsp.lua
--                   -- false: do nothing
--                   -- if lsp_cfg is a table, merge table with with non-default gopls setup in go/lsp.lua, e.g.
--                   --   lsp_cfg = {settings={gopls={matcher='CaseInsensitive', ['local'] = 'your_local_module_path', gofumpt = true }}}
--  lsp_gofumpt = false, -- true: set default gofmt in gopls format to gofumpt
--  lsp_on_attach = nil, -- nil: use on_attach function defined in go/lsp.lua,
--                       --      when lsp_cfg is true
--                       -- if lsp_on_attach is a function: use this function as on_attach function for gopls
--  lsp_codelens = true, -- set to false to disable codelens, true by default
--  lsp_diag_hdlr = true, -- hook lsp diag handler
--  -- virtual text setup
--  lsp_diag_virtual_text = { space = 0, prefix = "" },
--  lsp_diag_signs = true,
--  lsp_diag_update_in_insert = false,
--  lsp_document_formatting = true,
--  -- set to true: use gopls to format
--  -- false if you want to use other formatter tool(e.g. efm, nulls)
--  gopls_cmd = nil, -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile","/var/log/gopls.log" }
--  gopls_remote_auto = true, -- add -remote=auto to gopls
--  dap_debug = true, -- set to false to disable dap
--  dap_debug_keymap = true, -- true: use keymap for debugger defined in go/dap.lua
--                           -- false: do not use keymap in go/dap.lua.  you must define your own.
--  dap_debug_gui = true, -- set to true to enable dap gui, highly recommand
--  dap_debug_vt = true, -- set to true to enable dap virtual text
--  build_tags = "tag1,tag2", -- set default build tags
--  textobjects = true, -- enable default text jobects through treesittter-text-objects
--  test_runner = 'go', -- richgo, go test, richgo, dlv, ginkgo
--  run_in_floaterm = false, -- set to true to run in float window.
--                           --float term recommand if you use richgo/ginkgo with terminal color
--}

-- " let g:go_highlight_build_constraints = 1
-- " " let g:go_highlight_methods = 1
-- " let g:go_highlight_operators = 1
-- " let g:go_highlight_structs = 1

-- " let g:go_highlight_types = 1
-- " let g:go_highlight_fields = 1
-- " let g:go_highlight_functions = 1
-- " let g:go_highlight_function_calls = 1
-- " let g:go_highlight_extra_types = 1
-- " let g:go_highlight_generate_tags = 1

-- " let g:go_highlight_space_tab_error = 0
-- " let g:go_highlight_array_whitespace_error = 0
-- " let g:go_highlight_trailing_whitespace_error = 0

-- " let g:go_auto_type_info = 1
-- " " let g:go_auto_sameids = 1

-- " let g:go_addtags_transform = "snakecase"
-- " let g:go_autodetect_gopath = 1
-- " let g:go_fmt_fail_silently = 0
-- " let g:go_fmt_command = "goimports"
-- " let g:go_metalinter_command='golangci-lint'
-- " " let g:go_def_mode = 'gopls'

-- " autocmd BufLeave *.go             normal! mG

-- " augroup go
-- "   autocmd!
-- "   " :GoBuild and :GoTestCompile
-- "   " autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
-- "   autocmd FileType go nmap <leader>b <Plug>(go-build)
-- "   " :GoTest
-- "   " autocmd FileType go nmap <leader>t  <Plug>(go-test)
-- "   " :GoRun
-- "   " autocmd FileType go nmap <leader>r  <Plug>(go-run)
-- "   " :GoInfo
-- "   " autocmd FileType go nmap <Leader>i <Plug>(go-info)
-- "   " :GoReferers
-- "   autocmd FileType go nmap <Leader>r <Plug>(go-referers)
-- "   " :GoMetaLinter
-- "   " autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)
-- "   " :GoDef
-- "   autocmd FileType go nmap gd <Plug>(go-def)
-- "   " :GoDescribe
-- "   autocmd FileType go nmap <leader>de <Plug>(go-describe)
-- "   " :GoRename
-- "   " autocmd FileType go nmap <leader>re <Plug>(go-rename)
-- "   " :GoCoverageToggle
-- "   autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
-- "   " :GoAlternate  commands :A, :AV, :AS and :AT
-- "   autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
-- "   autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
-- "   autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
-- " augroup END

-- " let g:go_def_mapping_enabled = 0

-- " " build_go_files is a custom function that builds or compiles the test file.
-- " " It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
-- " " function! s:build_go_files()
-- " "   let l:file = expand('%')
-- " "   if l:file =~# '^\f\+_test\.go$'
-- " "     call go#test#Test(0, 1)
-- " "   elseif l:file =~# '^\f\+\.go$'
-- " "     call go#cmd#Build(0)
-- " "   endif
-- " " endfunction
-- " " --concurrency=3
