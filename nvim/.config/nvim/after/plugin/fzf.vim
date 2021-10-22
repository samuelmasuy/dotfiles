let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

" File preview using bat
nnoremap <silent> <C-p> :call FzfFilePreview()<CR>
function! FzfFilePreview()
  let l:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {2..-1} | head -200" --expect=ctrl-v,ctrl-x'

  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return l:files
  endfunction

  function! s:edit_file(lines)
    if len(a:lines) < 2 | return | endif

    let l:cmd = get({'ctrl-x': 'split',
                 \ 'ctrl-v': 'vertical split',
                 \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')

    for l:item in a:lines[1:]
      let l:pos = strridx(l:item, ' ')
      let l:file_path = l:item[pos+1:-1]
      execute 'silent '. l:cmd . ' ' . l:file_path
    endfor
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink*':   function('s:edit_file'),
        \ 'options': '-m --preview-window=right:70%:noborder --prompt Files\> ' . l:fzf_files_options,
        \ 'down':    '70%'})

endfunction

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

nnoremap <silent> <expr> <Leader><Leader> ('').":Files\<CR>"
nnoremap <silent> <Leader>c        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>`        :Marks<CR>
nnoremap <silent> <Leader>m        :Maps<CR>
nnoremap <Leader>a        :Rg<Space>
nnoremap <leader>z :tabnew \| FZF $XDG_CONFIG_HOME<CR>
" nnoremap <leader>w :tabnew \| FZF $WORKPATH<CR>
" nnoremap <leader>fv :call fzf#run({'options': '--reverse --prompt "VimFiles"', 'down': 20, 'dir': '~/.vim/', 'sink': 'e' })<CR>
nnoremap <leader>w :call fzf#run({'source': 'fd -d 1 -t d', 'options': '--prompt "WorkDirs\> "', 'dir': '$WORKPATH', 'sink': 'e', 'window': { 'width': 0.9, 'height': 0.9 }})<CR><CR>

" fd -d 2 -t 'd'
