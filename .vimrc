set nocompatible              " be iMproved, required
filetype off                  " required

" ===============PLUGINS===================


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdcommenter'
" auto complete
Plugin 'ervandew/supertab'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"
"Plugin 'Valloric/YouCompleteMe' " Autocompletion.

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"supertab config
let g:SuperTabCrMapping=1

"airline config

let g:airline#extensions#tabline#enabled = 1
"Separators can be configured independently for the tabline, so here is how you can define "straight" tabs:
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
"
"
"let g:airline_powerline_fonts = 1

let g:airline_theme='jellybeans'
"let g:airline_theme='bubblegum'
"let g:airline_mode_map = {
  "\ '__' : '-',
  "\ 'n'  : 'N',
  "\ 'i'  : 'I',
  "\ 'R'  : 'R',
  "\ 'c'  : 'C',
  "\ 'v'  : 'V',
  "\ 'V'  : 'V',
  "\ '' : 'V',
  "\ 's'  : 'S',
  "\ 'S'  : 'S',
  "\ '' : 'S',
  "\ }


let g:airline_section_z = '%#__accent_bold#%{g:airline_symbols.linenr}%4l%#__restore__#%#__accent_bold#/%L%#__restore__# :%3v'

" ===============END PLUGINS================




" ===============GENERAL OPTIONS============
syntax on
set wildmenu
set title
set ruler
set wrap
set guioptions=T
set t_Co=256
set laststatus=2
set hidden

"line numbers, relative numbers, and a scroll off
set nu
set relativenumber
set so=2

"smart case sensitivty in searching, show results
"check keybind section for highlight toggle
set ignorecase
set smartcase
set incsearch
"set hlsearch
"#set laststatus=2
"set statusline+=%F

"4 spaces, expand tabs, etc
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
filetype indent on

"mute the error bell
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif


"highlight current line
set cursorline

"show current command in status bar
set showcmd


" ===============KEYBINDS===================

"set leader to space
let mapleader=" "

"double tap space to move back in the edit buffer
"f to move forward
nnoremap <Leader><Space> g;
nnoremap <Leader>f g,

"yank to system clipboard
"nnoremap <Leader>y "+y
"nnoremap <Leader>p "*y


"make splits open in the expected way
set splitbelow
set splitright

"use vim binds to move between panes
nnoremap <Leader>j <c-w>j
nnoremap <Leader>k <c-w>k
nnoremap <Leader>h <c-w>h
nnoremap <Leader>l <c-w>l

"move between buffers
nnoremap <Leader>n :bn<cr>
nnoremap <Leader>p :bp<cr>

"toggle search highlighting
nnoremap <silent> <Leader>/ :set hls!<cr>


" ===============COLORS===================

"colorscheme
colorscheme darcula



" ============FUNCTIONS, SCRIPTS==========

"trim trailing white space
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun

command! TrimWhitespace call TrimWhitespace()

nnoremap <silent> <Leader>t :TrimWhitespace<cr>

"Vim opens to the last edited position in a file
if has("autocmd")
      au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
