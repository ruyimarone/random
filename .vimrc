set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Plugin 'christoomey/vim-tmux-navigator'

" airline I think
"Plugin 'vim-airline/vim-airline'
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


syntax on

set wildmenu
set title
set ruler
set wrap
set guioptions=T

"lines
set nu
set relativenumber
set so=2

"Search
set ignorecase
set smartcase
set incsearch
"set hlsearch


"#set laststatus=2
"set statusline+=%F
"
set t_Co=256
set laststatus=2

set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

"color schemes
set background=dark
colorscheme blue
"colorscheme solarized


set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
filetype indent on

"make split navigation better (I think)
set splitbelow
set splitright

nnoremap <c-j> <c-w>j 
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap <c-n> :bn<cr>
nnoremap <c-p> :bp<cr>

"let g:tmux_navigator_no_mappings = 1

"nmap <silent> <c-h> :TmuxNavigateLeft<cr><esc>
"nmap <silent> <c-j> :TmuxNavigateDown<cr><esc>
"nmap <silent> <c-k> :TmuxNavigateUp<cr><esc>
"nmap <silent> <c-l> :TmuxNavigateRight<cr><esc>
"nmap <silent> <c-/> :TmuxNavigatePrevious<cr><esc>

"nnoremap <C-k> <C-w><C-k>
"nnoremap <C-l> <C-w><C-l>
"nnoremap <C-h> <C-w><C-h>

"nnoremap <silent> <C-j> :TmuxNavigateLeft<cr>
"nnoremap <silent> <C-J> :PluginInstall<cr>
"nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
"nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
"nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
"nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>



"make vim go to the last edited location in a file (maybe good??)
if has("autocmd")
      au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
