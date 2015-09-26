" vim:fdm=marker
" Author: Samuel Masuy and the vim community.

" To make a portable tar vim:
" bash <(curl -L https://raw.githubusercontent.com/junegunn/myvim/master/myvim)

" Tip Macros: important!!!
" "ap: put (print) content of macro in register a.
" "ayy: put back current line in register a (macro).
" switch to last file edited
" nnoremap <leader><leader> <c-^>

" Pre vim  --------------------------------------------------------------- {{{

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Better copy & paste.
set clipboard=unnamed
" See the commands typed in the right bottom corner.
set showcmd
" Make backspace behave like normal.
set bs=2

call plug#begin('~/.vim/plugged')

" Essential
Plug 'morhetz/gruvbox'
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch' " Adds Unix commands to vim.
Plug 'tpope/vim-surround' " To change surrounding quote: cs(' ;tag cst<th> ;to add quote ysW'
Plug 'tpope/vim-vinegar' " Enhance of netrw
Plug 'kien/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'mileszs/ack.vim'
Plug 'vim-scripts/ReplaceWithRegister'

Plug 'fatih/vim-go'
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Valloric/MatchTagAlways'
Plug 'Raimondi/delimitMate' " Provide automatic closing quotes, etc...
" Plug 'dahu/vim-fanfingtastic'
Plug 'vim-scripts/DirDiff.vim' " :DirDiff <A:Src Directory> <B:Src Directory>
" Plug 'vim-scripts/python.vim--Vasiliev'
"Plug 'vim-scripts/py_jump.vim'
Plug 'maksimr/vim-jsbeautify'
Plug 'EinfachToll/DidYouMean'
Plug 'mhinz/vim-startify'


" Not very necessary
" Plug 'scrooloose/nerdtree'
" Plug 'unblevable/quick-scope'
" Plug 'sjl/gundo.vim'
" Plug 'dahu/vimple'
" Plug 'mitsuhiko/vim-rst'
" Plug 'Rykka/riv.vim'
" Plug 'godlygeek/tabular' " visual mode :Tabularize/{Regex}
" Plug 'Lokaltog/vim-easymotion' " Activate with <leader><leader>w (by word) <leader><leader>fo (character o)
" Plug 'nathanaelkane/vim-indent-guides' " <leader>ig
" Plug 'terryma/vim-multiple-cursors'

" Syntax helpers
" Plug 'SirVer/ultisnips'
" Plug 'mattn/emmet-vim'
" Plug 'StanAngeloff/php.vim'
" Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'pangloss/vim-javascript'
" Plug 'burnettk/vim-angular'
" Plug 'plasticboy/vim-markdown'

" Dependencies
" Plug 'honza/vim-snippets'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'

" Plug '0x0dea/vim-molasses'
" Plug 'tommcdo/vim-exchange'
" Plug 'alfredodeza/pytest.vim'
" Plug 'vim-scripts/SQLComplete.vim'
" Plug 'marijnh/tern_for_vim'
" Plug 'altercation/vim-colors-solarized'
" Plug 'chriskempson/vim-tomorrow-theme'
" Plug 'junegunn/seoul256.vim'

call plug#end()

set nocompatible
filetype plugin indent on

" ------------------------------------------------------------------------ }}}
" Appearance  ------------------------------------------------------------ {{{

" Beautiful
set t_Co=256
" Auto Indent
set autoindent
" Enable syntax highlighting.
syntax on

" Show whitespace.
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Font for macvim.
if has("gui_running")
  set guifont=Monaco:h15
endif

" Color scheme.
set background=dark
colorscheme gruvbox

" ------------------------------------------------------------------------ }}}
" Miscellaneous settings ------------------------------------------------- {{{

" Show the line that have been wrapped.
let &showbreak='↪ '
" Gdiff vertical split
set diffopt+=vertical
" Completion options (select longest + show menu even if a single match is found)
set completeopt=longest,menuone
" Make Esc work faster.
set ttimeoutlen=50
" Always shows 5 lines above/below the cursor.
set scrolloff=5
" Increment decimal not octal numbers.
set nrformats=
" Horizontal split goes to the bottom.
set splitbelow
" Vertical split goes to the right.
set splitright

" Colorize the 80th column.
"set colorcolumn=81
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" Folding settings.

" Don't use TABs but spaces.
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Showing line numbers and length.
set relativenumber
" Show current line numbers.
set number
" Width of document.
set tw=79
" Don't automatically wrap on load.
set nowrap
" Don't automatically wrap text when typing.
set fo-=t

" Useful settings.
set history=700
set undolevels=700

" Make search case insensitive.
set hlsearch
set incsearch
set ignorecase
set smartcase

" Wildmode aka tab-completion options.
set wildmenu
set wildmode=full

" for argdo and bufdo without a trailing bang.
set hidden

" Disable backup and swap files.
set nobackup
set nowritebackup
set noswapfile

" ------------------------------------------------------------------------ }}}
" General Mapping  ------------------------------------------------------- {{{

" Disable un-VI keys.
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
" Avoid un-VI keys in ex mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Quick Fold and Unfold.
nnoremap <space> za
vnoremap <space> zf

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

" ------------------------------------------------------------------------ }}}
" Syntax support  -------------------------------------------------------- {{{
" python
" ------
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 formatoptions=croqj softtabstop=4 comments=:#\:,:#
autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr>
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
let python_highlight_all=1
let python_slow_sync=1

let g:syntastic_python_checkers=['flake8', 'python']

let g:syntastic_python_flake8_args='--ignore=E121,E124,E126,E261,E301,E303,E501,E721 --max-line-length=104'
" Don't warn on
"   E121 continuation line indentation is not a multiple of four
"   E124 closing bracket does not match visual indentation
"   E126 continuation line over-indented for hanging indent
"   E128 continuation line under-indented for visual indent
"   E261 at least two spaces before inline comment
"   E301 expected 1 blank line, found 0
"   E303 expected 2 blank lines, found <n>
"   E721 do not compare types, use 'isinstance()'

" Go
" ----------
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>c <Plug>(go-coverage)
autocmd FileType go nmap K <Plug>(go-doc)
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Javascript
" ----------
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal commentstring=//\ %s
autocmd FileType javascript noremap <buffer> <leader>r :call JsBeautify()<cr>
autocmd FileType javascript let b:javascript_fold = 0
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
let javascript_enable_domhtmlcss=1
let g:syntastic_javascript_checkers = ['jshint']

" ruby
" ----
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" php
" ---
autocmd FileType php setlocal shiftwidth=4 tabstop=8 softtabstop=4 expandtab

" Template language (SGML / XML too)
" ----------------------------------
autocmd FileType xml,html,htmljinja,htmldjango setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html setlocal commentstring=<!--\ %s\ -->
autocmd FileType htmljinja setlocal commentstring={#\ %s\ #}
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
let html_no_rendering=1
let g:syntastic_html_checkers = []
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType html noremap <buffer> <leader>r :call HtmlBeautify()<cr>

" CSS
" ---
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType css setlocal commentstring=/*\ %s\ */
autocmd FileType css noremap <buffer> <leader>r :call CSSBeautify()<cr>
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS

" Java
" ----
autocmd FileType java setlocal shiftwidth=2 tabstop=8 softtabstop=2 expandtab
autocmd FileType java setlocal commentstring=//\ %s
" disable java checker
let g:loaded_syntastic_java_javac_checker = 1

" rst
" ---
autocmd BufNewFile,BufRead *.txt setlocal ft=rst
autocmd FileType rst setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 formatoptions+=nqt
let g:syntastic_rst_checkers = ['rstcheck']

" C/Obj-C/C++
autocmd FileType c setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType objc setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType c setlocal commentstring=/*\ %s\ */
autocmd FileType cpp,objc setlocal commentstring=//\ %s
let c_no_curly_error=1
let g:syntastic_cpp_include_dirs = ['include', '../include']
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_c_include_dirs = ['include', '../include']
let g:syntastic_c_compiler = 'clang'

" vim
" ---
autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2

" JSON
" ----
autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" ------------------------------------------------------------------------ }}}
" Leader Key Mapping  ---------------------------------------------------- {{{

" Rebind <leader> key.
let g:mapleader = ','
noremap \ ,

" Open in a new tab .vimrc
nnoremap <leader>e :tabedit $MYVIMRC<CR>
" Pytest the current file.
"nnoremap <silent><leader>f <Esc>:Pytest file<CR>
" Remap visual block select.
nnoremap <leader>v <c-v>
" Quicksave command.
noremap <leader>s :w<CR>
" Map sort function to a key
vnoremap <leader>s :sort<CR>
" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>
" Reset space-tab
nnoremap <leader>re :retab<CR>

" swicth to last file edited
nnoremap <leader><leader> <c-^>

" Title helper with reStructuredText files.
" if (&ft=='rst')
function! s:Underline(level)
  if a:level == 1
    let symbol = '#'
    let overline = 1
  elseif a:level == 2
    let symbol = '*'
    let overline = 1
  elseif a:level == 3
    let symbol = '='
    let overline = 0
  elseif a:level == 4
    let symbol = '-'
    let overline = 0
  elseif a:level == 5
    let symbol = '~'
    let overline = 0
  else
    echom "Unknow level!"
    return
  endif
  let lineNo = line('.')
  let counter = strlen(getline('.'))
  let newLine = ''
  while counter > 0
    let newLine  = newLine . symbol
    let counter -= 1
  endwhile
  call append(lineNo, newLine)
  if overline > 0
    call append(lineNo-1, newLine)
    let lineNo = lineNo + 1
  endif
  call append(lineNo + 1, "")
  call cursor(lineNo+2,1)
endfunction

command! -nargs=? Underline call s:Underline(<q-args>)
" endif

" Google search word under cursor from http://www.vimbits.com/bits/551
nnoremap <leader>is :let @p=@"<cr>yiw:!open "https://www.google.com/search?q=""<cr><cr>
    \:let @"=@p<cr>
" Google search the definition of the word under cursor
nnoremap <leader>id :let @p=@"<cr>yiw:!open "https://www.google.com/search?q=define ""<cr><cr>
    \:let @"=@p<cr>

" Easy subsitute providing a previous pattern
nnoremap <leader>; :%s::cg<Left><Left><Left>
vnoremap <leader>; :s::g<Left><Left>

" ------------------------------------------------------------------------ }}}
" Plugins setup. --------------------------------------------------------- {{{
" Settings for vim-powerline
let s:uname = system("uname")
if s:uname == "Darwin\n"
  source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
  set laststatus=2
  " Hide the default mode text
  set noshowmode
  let g:Powerline_symbols = "fancy"
  set encoding=utf-8
  set fillchars+=stl:\ ,stlnc:\
  if has("gui_running")
    set guifont=Monaco\ for\ Powerline
  endif
endif

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1

" Use smartcase.
let g:neocomplete#enable_smart_case = 1

" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 1

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" Settings for syntastic
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" Settings for vim-multiple-cursors
" let g:multi_cursor_exit_from_insert_mode = 0
" let g:multi_cursor_exit_from_visual_mode = 0

" Settings for jedi-vim
" let g:jedi#popup_select_first = 0

" Settings for emmet-vim
" let g:user_emmet_expandabbr_key='<Tab>'

" Settings for super-tab
let g:SuperTabDefaultCompletionType = "context"

" Settings for nerdTree
" nnoremap <leader>x :NERDTreeToggle<CR>
" let NERDTreeIgnore=['.pyc$[[file]]']
" let NERDTreeShowHidden=1
" let NERDTreeMapActivateNode='<space>'

" Settings for nerdCommenter
let NERDSpaceDelims=1

" Settings for javascript-libraries-syntax.vim
" let g:used_javascript_libs = 'angularui'

" Settings for Ack.vim
" Ack on <leader>a
nnoremap <leader>a :Ack<space>
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ackhighlight = 1
let g:ack_autofold_results = 1
let g:ackpreview = 1

" Vimux settings
 " Prompt for a command to run
 nnoremap <leader>cc :VimuxPromptCommand<CR>
 " Run last command executed by VimuxRunCommand
 nnoremap <leader>cu :VimuxRunLastCommand<CR>

" Settings for Gundo
" nnoremap <leader>g :GundoToggle<CR>

"Settings for Ctrlp
set wildignore+=*.pyc
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'
" let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" Settings for fugitive
nnoremap <leader>gdi :Gdiff<cr>
nnoremap <leader>gst :Gstatus<cr>
nnoremap <leader>dup :diffupdate<cr>

" ------------------------------------------------------------------------ }}}
