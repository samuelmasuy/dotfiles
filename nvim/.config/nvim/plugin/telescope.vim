lua require("sam")
lua require('plenary.reload').reload_module("sam.telescope")
nnoremap <leader>e <cmd>lua require('sam.telescope').edit_neovim()<CR>
nnoremap <leader><leader> :lua require('sam.telescope').search_files()<CR>
nnoremap <leader>z :lua require('sam.telescope').search_configs()<CR>
" nnoremap <leader>a :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <silent> <leader>a :lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>c :lua require('telescope.builtin').colorscheme()<CR>
nnoremap <leader><Enter> :lua require('telescope.builtin').buffers()<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>m :lua require('telescope.builtin').keymaps()<CR>
nnoremap <space>ca :lua require('sam.telescope').lsp_code_actions()<CR>
nnoremap <leader>t :Telescope<CR>

