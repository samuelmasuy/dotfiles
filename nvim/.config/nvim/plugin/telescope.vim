lua require("sam")
lua require("plenary.reload").reload_module("sam.telescope")

nnoremap <leader>t <cmd>Telescope<cr>

"search
nnoremap <C-p> <cmd>lua require('sam.telescope').search_files()<cr>
nnoremap <leader><leader> <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>z <cmd>lua require('sam.telescope').search_configs()<cr>
nnoremap <leader>j <cmd>lua require('sam.telescope').search_work_dirs()<cr>

nnoremap <silent> <leader>f <cmd>lua require('telescope').extensions.frecency.frecency()<cr>

nnoremap <silent> <leader>a <cmd>lua require('telescope.builtin').live_grep()<cr>

nnoremap <leader>e <cmd>lua require('sam.telescope').edit_neovim()<cr>


"utils
nnoremap <leader>c <cmd>lua require('telescope.builtin').colorscheme()<cr>
nnoremap <leader><enter> <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>m <cmd>lua require('telescope.builtin').keymaps()<cr>
nnoremap <space>ca <cmd>lua require('sam.telescope').lsp_code_actions()<cr>
