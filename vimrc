" vim:fdm=marker
" Author: Samuel Masuy and the vim community.

" set noro

" Tip:
" "ap: put (print) content of macro in register a.
" "ayy: put back current line in register a (macro).
" switch to last place edited: ''
" <C-o> in insert mode is awesome
" To make a portable tar vim:
" bash <(curl -L https://raw.githubusercontent.com/junegunn/myvim/master/myvim)

" Pre vim  --------------------------------------------------------------- {{{

" Automatic reloading of vimrc
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

if has('nvim')
  call plug#begin('~/.config/nvim/plugged')
  " Essential
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-eunuch' " Adds Unix commands to vim.
  Plug 'tpope/vim-surround' " To change surrounding quote: cs(' ;tag cst<th> ;to add quote ysW'
  Plug 'tpope/vim-vinegar' " Enhance netrw
  Plug 'tpope/vim-abolish' " Camel case, snake crc
  Plug 'tpope/vim-markdown', {'for': ['markdown', 'md']}
  Plug 'tpope/vim-fugitive' " awesome git
  Plug 'tpope/vim-rhubarb' " Companion of fugitive for integration with Github

  Plug 'justinmk/vim-dirvish' " minimalist directory viewer -

  Plug 'dense-analysis/ale'

  Plug 'Chiel92/vim-autoformat'

  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " colorscheme
  Plug 'joshdick/onedark.vim' " one
  Plug 'chriskempson/base16-vim' " rest

  Plug 'vim-airline/vim-airline'

  " search
  Plug 'airblade/vim-rooter' " auto cwd in root git repo
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-peekaboo' " what's in @ and \"

  " Encryption
  Plug 'jamessan/vim-gnupg'

  " utils
  Plug 'mhinz/vim-startify' " start up screen
  Plug 'mhinz/vim-sayonara' " quit
  Plug 'Valloric/MatchTagAlways'
  Plug 'Valloric/ListToggle' " quick*fix* *l*ocation
  Plug 'vim-scripts/DirDiff.vim' " :DirDiff <A:Src Directory> <B:Src Directory>
  Plug 'bronson/vim-trailing-whitespace' " show them
  Plug 'godlygeek/tabular' " :'<,'>Tabularize /:
  Plug 'vim-scripts/visSum.vim' " <leader>su
  Plug 'vim-scripts/VisIncr' " Increment all the things v-select jan\njan\njan :IM.
  " Plug 'mbbill/undotree'
  " Plug 'machakann/vim-highlightedyank'
  Plug 'christoomey/vim-sort-motion' " sort lines characters arguments etc

  " Plug 'fmoralesc/vim-tutor-mode'

  Plug 'janko/vim-test'

  Plug 'tmux-plugins/vim-tmux' " tmux.conf
  Plug 'christoomey/vim-tmux-navigator'

  " all hashicorp goodie
  Plug 'hashivim/vim-hashicorp-tools'

  Plug 'fatih/vim-go'
  Plug 'buoto/gotests-vim', {'for': ['go'],  'do': ':!go get -u github.com/cweill/gotests/...' }

  Plug 'pangloss/vim-javascript', {'for': ['javascript', 'typescript']} " syntax

  Plug 'leafgarland/typescript-vim', {'for': ['typescript']} " syntax

  Plug 'rhysd/vim-grammarous', { 'for': ['text', 'markdown']}
  Plug 'ron89/thesaurus_query.vim', { 'for': ['text', 'markdown']}
  Plug 'chrisbra/unicode.vim', { 'for': ['text', 'markdown']}

  " Plug 'stephpy/vim-yaml', {'for': ['yaml']}

  " Plug 'mhinz/vim-rfc' " sudo gem install nokogiri
  " Plug 'vim-scripts/rfc-syntax', { 'for': 'rfc' }

  Plug 'modille/groovy.vim', { 'for': ['groovy', 'Jenkinsfile']}

  Plug 'NLKNguyen/cloudformation-syntax.vim'

  Plug 'mustache/vim-mustache-handlebars', {'for': ['*.mustache']}

  Plug 'vim-scripts/haproxy', {'for': ['haproxy*']}

  Plug 'cespare/vim-toml', {'for': ['*.toml']}

  Plug 'ryanoasis/vim-devicons' " must be last
  call plug#end()
endif

" Better copy & paste.
if has('mac')
  set clipboard=unnamed
elseif has('unix') && (executable('pbcopy') || executable('xclip') || executable('xsel')) && has('clipboard')
  set clipboard+=unnamedplus
endif

" See the commands typed in the right bottom corner.
set showcmd

if !has('nvim')
  " Make backspace behave like normal.
  set bs=2
  " Auto Indent
  set autoindent
endif

filetype plugin indent on

" ------------------------------------------------------------------------ }}}
" Appearance  ------------------------------------------------------------ {{{
" Enable syntax highlighting.
syntax on

set background=dark

" Beautiful
if has('nvim') && has("termguicolors")
  set termguicolors
  silent! colorscheme onedark
  let g:airline_theme = 'onedark'
  " let g:onedark_terminal_italics = 1
endif

" ------------------------------------------------------------------------ }}}
" Miscellaneous settings ------------------------------------------------- {{{

set expandtab shiftwidth=4 tabstop=4 softtabstop=4

set encoding=utf8

set autowrite
set inccommand=nosplit
" Show the line that have been wrapped.
let &showbreak='↪ '
" Gdiff vertical split
set diffopt+=vertical
" Completion options (select longest + show menu even if a single match is found)
" set completeopt=menuone,noselect
" set completeopt+=noselect
autocmd CompleteDone * pclose
" Make Esc work faster.
set ttimeoutlen=40
" Always shows 5 lines above/below the cursor.
set scrolloff=5
" Increment decimal not octal numbers.
set nrformats=
" Horizontal split goes to the bottom.
set splitbelow
" Vertical split goes to the right.
set splitright
" Automatically reread changed files without asking me anything
set autoread
" speed up syntax highlighting
set nocursorcolumn
set nocursorline

" Colorize the 100th column if goes over.
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%101v', 100)

" Showing line numbers and length.
" set relativenumber
" Show current line numbers.
set number
" Width of document.
set tw=79
" Don't automatically wrap on load.
set nowrap
" Don't automatically wrap text when typing.
set fo-=t

if !has('nvim')
  " Useful settings.
  set history=700
  " Make search case insensitive.
  set hlsearch
  set incsearch
  " Tab-completion options.
  set wildmenu
endif

" How many undos
set undolevels=1000
" Undo file
set undodir=~/.config/nvim/undos
set undofile

set ignorecase
set smartcase

" Wildmode aka tab-completion options.
set wildmode=full

" for argdo and bufdo without a trailing bang.
set hidden

" Disable backup and swap files.
set nobackup
set nowritebackup
set noswapfile

" Disable mouse click to go to position
set mouse-=a

set noshowmode

if executable("rg")
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

" gnupg
set modeline
set modelines=5

" ------------------------------------------------------------------------ }}}
" General Mapping  ------------------------------------------------------- {{{

" try to use gs
cnoremap wq :echo 'Use gs'<CR>
cnoremap q! :echo 'Use gs'<CR>

" Disable un-VI keys.
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Quick Fold and Unfold.
" nnoremap <space> za
" vnoremap <space> zf

" Make sure to be in the middle of the screen when searching.
nnoremap n nzzzv
nnoremap N Nzzzv

" Easier indentation of code blocks.
vnoremap < <gv
vnoremap > >gv

" basic, why not before
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" logical
nnoremap Y y$

" Switch marks
nnoremap ' `
nnoremap ` '

" Don't move on *
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

if has('nvim')
  " Terminal mode
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
endif

" ------------------------------------------------------------------------ }}}
" Leader Key Mapping  ---------------------------------------------------- {{{

" Rebind <leader> key.
let g:mapleader = ','
noremap \ ,

" Open in a new tab .vimrc
nnoremap <leader>e :tabedit $MYVIMRC<CR>
" Remap visual block select.
nnoremap <leader>v <c-v>
"Open new vertical split
nnoremap <leader>vs :vsplit<CR>
" Map sort function to a key
vnoremap <leader>s :sort<CR>
" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>
" Reset space-tab
nnoremap <leader>reta :retab<CR>

" cd to where the file is currently located
nnoremap <leader>. :lcd %:p:h<CR>

" Google search word under cursor from http://www.vimbits.com/bits/551
nnoremap <leader>is :let @p=@"<cr>yiw:!open "https://www.google.com/search?q=""<cr><cr>
      \:let @"=@p<cr>

vnoremap <leader>is y:!open "https://www.google.com/search?q=""<cr><cr>

" Google search the definition of the word under cursor
nnoremap <leader>id :let @p=@"<cr>yiw:!open "https://www.google.com/search?q=define ""<cr><cr>
      \:let @"=@p<cr>

" urlencode selection
vnoremap <leader>en :!python -c 'import sys,urllib;print urllib.quote(sys.stdin.read().strip())'<cr>

" Easy substitution
nnoremap <leader>; :%s::cg<Left><Left><Left>
vnoremap <leader>; :s::g<Left><Left>

" redraw screen
nnoremap <leader>1 :redraw!<CR>

" use <Leader>H,J,K,L to swap windows
map <silent> <Leader>H :vertical :resize +5<CR>
map <silent> <Leader>J :resize -5<CR>
map <silent> <Leader>K :resize +5<CR>
map <silent> <Leader>L :vertical :resize -5<CR>

nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
" ------------------------------------------------------------------------ }}}
" Syntax support  -------------------------------------------------------- {{{
" python ----------------------------------------------------------------- {{{
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 formatoptions=croqj softtabstop=4 comments=:#\:,:#
autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr>
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
let python_highlight_all=1
let python_slow_sync=1
autocmd BufLeave *.py               normal! mP

" ------------------------------------------------------------------------ }}}
" Go --------------------------------------------------------------------- {{{
let g:go_highlight_build_constraints = 1
" let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0

let g:go_auto_type_info = 1
" let g:go_auto_sameids = 1

let g:go_addtags_transform = "snakecase"
let g:go_autodetect_gopath = 1
let g:go_fmt_fail_silently = 0
let g:go_fmt_command = "goimports"
" let g:go_snippet_engine = "ultisnips"
let g:go_metalinter_command='golangci-lint'
" let g:go_def_mode = 'gopls'

autocmd BufLeave *.go             normal! mG

augroup go
  autocmd!
  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
  " :GoBuild and :GoTestCompile
  " autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <leader>b <Plug>(go-build)
  " :GoTest
  " autocmd FileType go nmap <leader>t  <Plug>(go-test)
  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)
  " :GoDoc
  " autocmd FileType go nmap K <Plug>(go-doc)
  " :GoInfo
  " autocmd FileType go nmap <Leader>i <Plug>(go-info)
  " :GoReferers
  " autocmd FileType go nmap <Leader>i <Plug>(go-referers)
  " :GoMetaLinter
  " autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)
  " :GoDef
  autocmd FileType go nmap gd <Plug>(go-def)
  " :GoDescribe
  autocmd FileType go nmap <leader>de <Plug>(go-describe)
  " :GoRename
  " autocmd FileType go nmap <leader>re <Plug>(go-rename)
  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
augroup END

let g:go_def_mapping_enabled = 0

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
" function! s:build_go_files()
"   let l:file = expand('%')
"   if l:file =~# '^\f\+_test\.go$'
"     call go#test#Test(0, 1)
"   elseif l:file =~# '^\f\+\.go$'
"     call go#cmd#Build(0)
"   endif
" endfunction
" --concurrency=3
let g:ale_go_gometalinter_options = "--tests --enable-gc --fast -D aligncheck -D dupl -D gocyclo -D gotype -D gas -E errcheck -E misspell -E unused --severity=unused:error --severity=errcheck:error"

" ------------------------------------------------------------------------ }}}
" Javascript ------------------------------------------------------------- {{{
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal commentstring=//\ %s
autocmd FileType javascript noremap <leader>r :ALEFix<CR>
autocmd BufLeave *.js             normal! mJ

autocmd FileType javascript let b:javascript_fold = 0
let javascript_enable_domhtmlcss=1

" ------------------------------------------------------------------------ }}}
" Typescript ------------------------------------------------------------- {{{
" autocmd FileType typescript setlocal completeopt+=menu,preview
autocmd FileType typescript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType typescript noremap <leader>r :ALEFix<CR>
autocmd BufLeave *.ts             normal! mT

" ------------------------------------------------------------------------ }}}
" ruby ------------------------------------------------------------------- {{{
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" ------------------------------------------------------------------------ }}}
" php -------------------------------------------------------------------- {{{
autocmd FileType php setlocal shiftwidth=4 tabstop=8 softtabstop=4 expandtab

" ------------------------------------------------------------------------ }}}
" Template language (HTML / SGML / XML) ------------------------------------- {{{
autocmd FileType xml,html,htmljinja,htmldjango setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html setlocal commentstring=<!--\ %s\ -->
autocmd FileType htmljinja setlocal commentstring={#\ %s\ #}
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
let html_no_rendering=1
autocmd FileType html noremap <leader>r :ALEFix<CR>
autocmd BufLeave *.html             normal! mH
let g:formatters_html = ['custom_html']

" ------------------------------------------------------------------------ }}}
" CSS -------------------------------------------------------------------- {{{
autocmd FileType css,scss setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType css,scss setlocal commentstring=/*\ %s\ */
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType css,less,scss noremap <leader>r :ALEFix<CR>
autocmd BufLeave *.css,*.less,*scss normal! mC

" ------------------------------------------------------------------------ }}}
" Java ------------------------------------------------------------------- {{{
autocmd FileType java setlocal shiftwidth=2 tabstop=8 softtabstop=2 expandtab
autocmd FileType java setlocal commentstring=//\ %s
" ------------------------------------------------------------------------ }}}
" Groovy ----------------------------------------------------------------- {{{
autocmd FileType groovy setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType groovy setlocal commentstring=//\ %s
autocmd FileType groovy noremap <leader>b :!groovy %<CR>


" ------------------------------------------------------------------------ }}}
" rst -------------------------------------------------------------------- {{{
autocmd BufEnter *.txt setlocal spell
autocmd FileType rst setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 formatoptions+=nqt

" ------------------------------------------------------------------------ }}}
" shell ------------------------------------------------------------------ {{{
autocmd FileType sh,bash,zsh setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType sh,bash,zsh noremap <leader>r :Autoformat<CR>

" ------------------------------------------------------------------------ }}}
" C/Obj-C/C++ ------------------------------------------------------------ {{{
autocmd FileType c,cpp setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab textwidth=80
autocmd FileType objc setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab textwidth=80
autocmd FileType c setlocal commentstring=/*\ %s\ */
autocmd FileType cpp,objc setlocal commentstring=//\ %s
autocmd FileType c,cpp noremap <buffer> <leader>r :%!astyle --mode=c --style=google -n -s2<CR>
let c_no_curly_error=1

" ------------------------------------------------------------------------ }}}
" vim -------------------------------------------------------------------- {{{
autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" ------------------------------------------------------------------------ }}}
" JSON ------------------------------------------------------------------- {{{
autocmd FileType json setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType json noremap <leader>r :ALEFix<CR>

" ------------------------------------------------------------------------ }}}
" markdown --------------------------------------------------------------- {{{
autocmd FileType md,markdown setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType md,markdown,wiki setlocal omnifunc=htmlcomplete#CompleteTags
autocmd BufNewFile,BufRead *.txt setlocal ft=markdown
autocmd FileType md,markdown,wiki setlocal spell
autocmd FileType gitcommit setlocal spell
autocmd FileType gitcommit setlocal completefunc=emoji#complete
autocmd FileType md,markdown noremap <leader>r :ALEFix<CR>
let g:markdown_syntax_conceal = 0
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'javascript', 'go', 'css']

" ------------------------------------------------------------------------ }}}
" yaml --------------------------------------------------------------- {{{
autocmd FileType yaml,yml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType yaml,yml noremap <leader>r :ALEFix<CR>

" ------------------------------------------------------------------------ }}}
" Tug ----------------------------------------------------------------- {{{
autocmd BufRead,BufNewFile *.Tugfile set filetype=terraform
autocmd BufRead,BufNewFile Tugfile set filetype=terraform
autocmd FileType terraform noremap <leader>r :TerraformFmt<CR>

" ------------------------------------------------------------------------ }}}
" haproxy ----------------------------------------------------------------- {{{
autocmd BufRead,BufNewFile haproxy* set filetype=haproxy
autocmd FileType haproxy setlocal commentstring=#\ %s
" ------------------------------------------------------------------------ }}}
" rust ------------------------------------------------------------------- {{{
autocmd FileType rust noremap <leader>r :ALEFix<CR>
" ------------------------------------------------------------------------ }}}
" ------------------------------------------------------------------------ }}}
" Plugins config --------------------------------------------------------- {{{
" ale ------------------------------------------------------------ {{{
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '☂'
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_enter = 0
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_linters = {
\  'typescript': ['tslint', 'typecheck', 'tsserver'],
\  'sh': ['shfmt', 'shellcheck'],
\  'yaml': ['yamllint'],
\  'cloudformation': ['cfn-python-lint'],
\  'gitcommit': ['gitlint'],
\  'dockerfile': ['hadolint'],
\  'json': ['jsonlint'],
\  'go': ['gometalinter'],
\  'terraform': ['tflint', 'fmt'],
\  'rust': ['rls']
\}

let g:ale_fixers = {
\  'javascript': ['prettier'],
\  'typescript': ['prettier'],
\  'css': ['prettier'],
\  'markdown': ['prettier'],
\  'json': ['prettier'],
\  'html': ['prettier'],
\  'yaml': ['prettier'],
\  'rust': ['rustfmt']
\}

" let g:ale_linters_explicit = 1
" ------------------------------------------------------------------------ }}}
" fzf ------------------------------------------------------------- {{{
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

" File preview using bat
nnoremap <silent> <C-p> :call FzfFilePreview()<CR>
function! FzfFilePreview()
  let l:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {2..-1} | head -200" --expect=ctrl-v,ctrl-x'

  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
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

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let options = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  if a:fullscreen
    let options = fzf#vim#with_preview(options)
  endif
  call fzf#vim#grep(initial_command, 1, options, a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)
nnoremap <Leader>a        :Rg<Space>

nnoremap <silent> <expr> <Leader><Leader> ('').":Files\<CR>"
nnoremap <silent> <Leader>c        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>`        :Marks<CR>
nnoremap <silent> <Leader>m        :Maps<CR>

" ------------------------------------------------------------------------ }}}
" coc.nvim -------------------------------------------------------- {{{

" Better display for messages
" set cmdheight=1
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
if has_key(g:plugs, 'coc.nvim')
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:show_documentation()
    if (index(['vim', 'help'], &filetype) >= 0)
      execute 'h' expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  nnoremap <silent> K :call <SID>show_documentation()<CR>

  let g:coc_global_extensions = ['coc-github', 'coc-yaml', 'coc-python',
    \ 'coc-html', 'coc-json', 'coc-css', 'coc-rls', 'coc-vimlsp',
    \ 'coc-tsserver', 'coc-emoji', 'coc-java']

  let g:go_doc_keywordprg_enabled = 0

  augroup coc-config
    autocmd!
    autocmd VimEnter * nmap <silent> gd <Plug>(coc-definition)
    autocmd VimEnter * nmap <silent> gi <Plug>(coc-implementation)
    autocmd VimEnter * nmap <silent> g? <Plug>(coc-references)
    autocmd VimEnter * nmap <silent> gy <Plug>(coc-type-definition)
    autocmd VimEnter * nmap <silent> gr <Plug>(coc-references)
    " Use `[c` and `]c` to navigate diagnostics
    autocmd VimEnter * nmap <silent> [c <Plug>(coc-diagnostic-prev)
    autocmd VimEnter * nmap <silent> ]c <Plug>(coc-diagnostic-next)
    " Remap for rename current word
    autocmd VimEnter * nmap <leader>rn <Plug>(coc-rename)
  augroup END

  " Show all diagnostics
  " nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
  " " Manage extensions
  " nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
  " " Show commands
  " nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
  " " Find symbol of current document
  " nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
  " " Search workspace symbols
  " nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
  " " Do default action for next item.
  " nnoremap <silent> <space>j  :<C-u>CocNext<CR>
  " " Do default action for previous item.
  " nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
  " " Resume latest coc list
  " nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
  "
  "Examples
  " Use <C-l> for trigger snippet expand.
  imap <C-l> <Plug>(coc-snippets-expand)

  " Use <C-j> for select text for visual placeholder of snippet.
  vmap <C-j> <Plug>(coc-snippets-select)

  " Use <C-j> for jump to next placeholder, it's default of coc.nvim
  let g:coc_snippet_next = '<c-j>'

  " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
  let g:coc_snippet_prev = '<c-k>'

  " Use <C-j> for both expand and jump (make expand higher priority.)
  imap <C-j> <Plug>(coc-snippets-expand-jump)
endif
" ------------------------------------------------------------------------ }}}
" Others. ------------------------------------------------------------- {{{
" Settings for vim-airline
let g:airline_powerline_fonts = 0
set laststatus=2
let g:airline#extensions#whitespace#checks = []
let g:webdevicons_enable_airline_statusline = 0
let g:airline_section_y = ''
let g:airline_skip_empty_sections = 1

" adding icons to vim-startify screen
let g:webdevicons_enable_startify = 1

" Settings for sort-motion
let g:sort_motion = 'gso'
let g:sort_motion_lines = 'gsos'
let g:sort_motion_visual = 'gso'

" Settings for terraform
let g:terraform_fmt_on_save=1

" Settings for sayonara
nnoremap gs :Sayonara<cr>

" Settings for ListToggle
let g:lt_quickfix_list_toggle_map = '<leader>fix'
" let g:lt_location_list_toggle_map = '<leader>l' " <- default

" hcl
let g:tf_fmt_autosave = 0
let g:nomad_fmt_autosave = 0
autocmd BufNewFile,BufRead *.hcl setf conf
autocmd BufNewFile,BufRead *.hcl setlocal expandtab shiftwidth=2 tabstop=2

" vim-test
let test#strategy = "neovim"
" ---------------------------------------------------------------- }}}
" ------------------------------------------------------------------------- }}}
