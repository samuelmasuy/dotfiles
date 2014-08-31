" Author: Samuel Masuy and the vim community.

" Pre vim  --------------------------------------------------------------- {{{

" Setup Pathogen to manage plugins.
"call pathogen#infect()

" fix tmux background color.
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" Remap for escape key.
inoremap jj <ESC>

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %
command! -nargs=* Wrap set wrap linebreak nolist

set nocompatible
set t_Co=256
filetype off

" Better copy & paste.
set clipboard=unnamed
" See the commands typed in the right bottom corner.
set showcmd
" Make backspace behave like normal again.
set bs=2

" Vundle set up
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'vim-scripts/SQLComplete.vim'
Bundle 'davidhalter/jedi-vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'morhetz/gruvbox'
Bundle 'scrooloose/nerdcommenter'
Bundle 'ervandew/supertab'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'StanAngeloff/php.vim'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle 'honza/vim-snippets'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Bundle 'alfredodeza/pytest.vim'
Bundle 'terryma/vim-multiple-cursors'

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
"set background=dark
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
set foldmethod=marker

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

" Make sure to be in the middle of the screen when searching.
nnoremap n nzzzv
nnoremap N Nzzzv

" Easier indentation of code blocks.
vnoremap < <gv
vnoremap > >gv

" ------------------------------------------------------------------------ }}}
" Leader Key Mapping  ---------------------------------------------------- {{{

"basic, why not before
nnoremap ; :
nnoremap : ;

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
nnoremap <silent><Leader>f <Esc>:Pytest file<CR>
" Remap visual block select.
nnoremap <Leader>v <c-v>
" Quicksave command.
noremap <Leader>s :w<CR>
" Toggle spell check.
nnoremap <leader>z :setlocal spell! spelllang=en_us<CR>
" Map sort function to a key
vnoremap <Leader>s :sort<CR>



" Easier moving between tabs.
nnoremap <Leader>m <esc>:tabnext<CR>
nnoremap <Leader>n <esc>:tabprevious<CR>

" ------------------------------------------------------------------------ }}}
" Plugins setup. --------------------------------------------------------- {{{
source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
" Settings for vim-powerline
set laststatus=2
" Hide the default mode text (e.g. -- INSERT -- below the statusline)
set noshowmode
let g:Powerline_symbols = "fancy"
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
"set term=xterm-256color
if has("gui_running")
   let s:uname = system("uname")
   if s:uname == "Darwin\n"
      set guifont=Monaco\ for\ Powerline
   endif
endif

" Settings for ctrlp
let g:ctrlp_max_height = 20
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_map = '<leader>t'

" Settings for jedi-vim
let g:jedi#popup_select_first = 0

" Settings for super-tab
let g:SuperTabDefaultCompletionType = "context"

" Settings for nerdTree
nnoremap <Leader>x :NERDTreeToggle<CR>
let NERDTreeIgnore=['.pyc$[[file]]']
let NERDTreeShowHidden=1
let NERDTreeMapActivateNode='<space>'

" Setting for vim-css-colors
let g:cssColorVimDoNotMessMyUpdatetime = 1

" Settings for hard mode.
"autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>
" ------------------------------------------------------------------------ }}}

