local Remap = require("sam.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local noremap = Remap.noremap

noremap("\\", ",")
-- Open in a new tab .vimrc
-- keymap.set("n", "<leader>e", ":tabedit $MYVIMRC<CR>")
-- Remap visual block select.
-- keymap.set("n", "<leader>v", "<c-v>")
-- Open new vertical split
nnoremap("<leader>v", ":vsplit<CR>")
-- Map sort function to a key
-- keymap.set("v", "<leader>s", ":sort<CR>")
-- Remove trailing whitespace on <leader>S
nnoremap("<leader>S", ":%s/\\s\\+$//<cr>:let @/=''<CR>")
-- Reset space-tab
-- keymap.set("n", "<leader>reta", ":retab<CR>")

-- cd to where the file is currently located
nnoremap("<leader>.", ":lcd %:p:h<CR>")

-- Google search word under cursor from http://www.vimbits.com/bits/551
nnoremap("<leader>is", ':let @p=@"<cr>yiw:!open "https://www.google.com/search?q=""<cr><cr>:let @"=@p<cr>')
vnoremap("<leader>is", 'y:!open "https://www.google.com/search?q=""<cr><cr>')
-- Google search the definition of the word under cursor
nnoremap("<leader>id", ':let @p=@"<cr>yiw:!open "https://www.google.com/search?q=define ""<cr><cr>:let @"=@p<cr>')

-- urlencode selection
vnoremap("<leader>en", ":!python -c 'import sys,urllib;print urllib.quote(sys.stdin.read().strip())'<cr>")

-- Easy substitution
nnoremap("<leader>;", ":%s::cg<Left><Left><Left>")
vnoremap("<leader>;", ":s::g<Left><Left>")

-- Don't lose what's in "" register
vnoremap("<leader>p", '"_dP')

-- redraw screen
-- keymap.set("n", "<leader>1", ":redraw!<CR>")

-- use <Leader>H,J,K,L to resize windows
noremap("<leader>H", ":vertical :resize +5<CR>", { silent = true })
noremap("<leader>J", ":resize -5<CR>", { silent = true })
noremap("<leader>K", ":resize +5<CR>", { silent = true })
noremap("<leader>L", ":vertical :resize -5<CR>", { silent = true })

nnoremap("<leader>tn", ":TestNearest<CR>")
nnoremap("<leader>tf", ":TestFile<CR>")
