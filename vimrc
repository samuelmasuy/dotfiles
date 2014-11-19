" vim:fdm=marker
" Author: Samuel Masuy and the vim community.

" Pre vim  --------------------------------------------------------------- {{{

" Setup Pathogen to manage plugins.
"call pathogen#infect()

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %
" Settings for wrap
command! -nargs=* Wrap set wrap linebreak nolist

set nocompatible
set t_Co=256
filetype off

" Better copy & paste.
set clipboard=unnamed
" See the commands typed in the right bottom corner.
set showcmd
" Make backspace behave like normal.
set bs=2

" Vundle set up.
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Necessary
Plugin 'gmarik/vundle'
Plugin 'morhetz/gruvbox'
Plugin 'davidhalter/jedi-vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
" To change surrounding quote: cs"' ;tag cst<th> ;to add quote ysW'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'SirVer/ultisnips'
Plugin 'mattn/emmet-vim'
" :DirDiff <A:Src Directory> <B:Src Directory>
Plugin 'vim-scripts/DirDiff.vim'
" Activate with <leader><leader>w (by word) <leader><leader>fo (character o)
Plugin 'Lokaltog/vim-easymotion'
" <leader>ig
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Valloric/MatchTagAlways'
" Provide automatic closing quotes, etc...
Plugin 'Raimondi/delimitMate'

" Not very necessary
" visual mode :Tabularize/{Regex}
Plugin 'godlygeek/tabular'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'sjl/gundo.vim'

" Syntax helpers
Plugin 'StanAngeloff/php.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'burnettk/vim-angular'
Plugin 'plasticboy/vim-markdown'

" Dependencies
Plugin 'honza/vim-snippets'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'

" Plugin 'tommcdo/vim-exchange'
" Plugin 'alfredodeza/pytest.vim'
" Plugin 'vim-scripts/SQLComplete.vim'
" Plugin 'marijnh/tern_for_vim'
" Plugin 'altercation/vim-colors-solarized'
" Plugin 'junegunn/seoul256.vim'


filetype plugin indent on

" ------------------------------------------------------------------------ }}}
" Appearance  ------------------------------------------------------------ {{{

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
else
    let g:gruvbox_italicize_comments=0
endif

" Color scheme.
colorscheme gruvbox
"colorscheme seoul256
set background=dark
"colorscheme solarized

" ------------------------------------------------------------------------ }}}
" Miscellaneous settings ------------------------------------------------- {{{

" Show the line that have been wrapped.
let &showbreak='↪ '
" Gdiff vertical split
set diffopt+=vertical
" Make Esc work faster.
set ttimeoutlen=50
" Always shows 5 lines above/below the cursor.
set scrolloff=5

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

" Quick Fold and Unfold.
nnoremap <space> za
vnoremap <space> zf

" Go start and end of line.
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

" Make sure to be in the middle of the screen when searching.
nnoremap n nzzzv
nnoremap N Nzzzv

" Easier indentation of code blocks.
vnoremap < <gv
vnoremap > >gv

"basic, why not before
nnoremap ; :
nnoremap : ;


" ------------------------------------------------------------------------ }}}
" Leader Key Mapping  ---------------------------------------------------- {{{

" Rebind <Leader> key.
let mapleader = ","

" Remap changing screen keys.
map <leader>h <C-w>h
map <leader>j <C-w>j
map <leader>k <C-w>k
map <leader>l <C-w>l
" Removes highlight of your last search.
nnoremap <silent> <leader>/ :nohlsearch<CR>
" Quickly toggle 'set list'
nnoremap <leader>c :set list!<CR>
" Open in a new tab .vimrc
nnoremap <leader>e :tabedit $MYVIMRC<CR>
" Pytest the current file.
"nnoremap <silent><Leader>f <Esc>:Pytest file<CR>
" Remap visual block select.
nnoremap <Leader>v <c-v>
" Quicksave command.
noremap <Leader>s :w<CR>
" Toggle spell check.
nnoremap <leader>z :setlocal spell! spelllang=en_us<CR>
" Map sort function to a key
vnoremap <Leader>s :sort<CR>
" Force paste on next line
nnoremap <leader>pu :pu<CR>
" Easier moving between tabs.
nnoremap <Leader>m <esc>:tabnext<CR>
nnoremap <Leader>n <esc>:tabprevious<CR>

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
    set term=xterm-256color
    if has("gui_running")
          set guifont=Monaco\ for\ Powerline
    endif
endif

" Settings for syntastic
let g:syntastic_python_checkers = ['pylint', 'flake8']
let g:syntastic_aggregate_errors = 1

" Settings for vim-multiple-cursors
let g:multi_cursor_exit_from_insert_mode = 0
let g:multi_cursor_exit_from_visual_mode = 0

" Settings for jedi-vim
let g:jedi#popup_select_first = 0

" Settings for UtilSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Settings for emmet-vim
let g:user_emmet_expandabbr_key='<Tab>'

" Settings for super-tab
let g:SuperTabDefaultCompletionType = "context"

" Settings for nerdTree
nnoremap <Leader>x :NERDTreeToggle<CR>
let NERDTreeIgnore=['.pyc$[[file]]']
let NERDTreeShowHidden=1
let NERDTreeMapActivateNode='<space>'

" Settings for nerdCommenter
let NERDSpaceDelims=1   

" Settings for javascript-libraries-syntax.vim
let g:used_javascript_libs = 'angularui'

" Settings for hard mode.
"autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
" ------------------------------------------------------------------------ }}}

