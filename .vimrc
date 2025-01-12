set nocompatible              " be iMproved, required
filetype off                  " required

"============================
"=        Plugins           =
"============================

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ervandew/supertab'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'nanotech/jellybeans.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rakr/vim-one'
Plugin 'drewtempelmeyer/palenight.vim'
Plugin 'google/vim-jsonnet'
Plugin 'junegunn/limelight.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'tpope/vim-sleuth'

" Neovim-specific plugins
if (has("nvim"))
    Plugin 'w0rp/ale'
    Plugin 'heavenshell/vim-pydocstring'
endif

call vundle#end()            " required
filetype plugin indent on    " required

"============================
"=     Plugins Config       =
"============================

" ALE Configuration
if has('nvim')
    let g:ale_python_pylint_options="--disable=W,C,R --extension-pkg-whitelist=torch,numpy"
    let g:ale_linters = {
    \  'python': ['pylint'],
    \}
endif

" Supertab Configuration
let g:SuperTabCrMapping=1

" Airline Configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_section_z = '%#__accent_bold#%{g:airline_symbols.linenr}%4l%#__restore__#%#__accent_bold#/%L%#__restore__# :%3v'

" Works better with git gutter
set updatetime=250

" CtrlP Configuration
let g:ctrlp_by_filename = 1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|node_modules\|__pycache__\|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }
nnoremap <c-f> :CtrlPLine<cr>

" Pydocstring Configuration
if has('nvim')
    noremap <silent> """ <Plug>(pydocstring)
    let g:pydocstring_formatter = 'sphinx'
    let g:pydocstring_doq_path = '~/anaconda3/bin/doq'
endif

" Goyo and Limelight config settings

function! s:goyo_enter()
    if executable('tmux') && strlen($TMUX)
        silent !tmux set status off
        silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    endif
    set noshowcmd
    set spell
    noremap <expr> k (v:count == 0 ? 'gk' : 'k')
    noremap <expr> j (v:count == 0 ? 'gj' : 'j')
    noremap <expr> $ (v:count == 0 ? 'g$' : '$')
    noremap <expr> ^ (v:count == 0 ? 'g^' : '^')
    noremap <expr> 0 (v:count == 0 ? 'g0' : '0')
    set wrap
    set linebreak
    set scrolloff=999
    set nocursorcolumn
    set eventignore=FocusGained
    Limelight

    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
    if executable('tmux') && strlen($TMUX)
        silent !tmux set status on
        silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    endif
    set showcmd
    set eventignore=
    unmap k
    unmap j
    unmap $
    unmap ^
    unmap 0
    set nowrap
    set scrolloff=2
    set cursorcolumn
    Limelight!

    " Quit Vim if this is the only remaining buffer
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        if b:quitting_bang
            qa!
        else
            qa
        endif
    endif
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

"============================
"=     General Config       =
"============================

syntax on
set wildmenu
set title
set ruler
set guioptions=T
set t_Co=256
set laststatus=2
set hidden


set scrolloff=2
set cursorline
set cursorcolumn
set showcmd

"when buffer swapping (and other things), don't move cursor in line
set nostartofline

"Searching
set ignorecase
set smartcase
set incsearch
set hlsearch

"Indentation settings
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4

"language specific indentation settings
autocmd Filetype ocaml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

"mute error bell
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

set display+=lastline

set mouse=a

"Vim opens to the last edited position in a file
if has("autocmd")
      au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

"============================
"=        Keybinds          =
"============================

"leader map
nnoremap <SPACE> <Nop>
let mapleader=" "

"double tap space to move in edit list or jump list

nnoremap <Leader><Space> g;
nnoremap <Leader>f g,
"nnoremap <Leader><Space> <c-o>
"nnoremap <Leader>f <c-i>

"yank to system clipboard
vnoremap <Leader>y "+y
"nnoremap <Leader>p "*y

"return curor to end of visual selection when yanking
vnoremap y ygv<Esc>

" toggle word wrapping
"nnoremap <silent> <Leader>w :set wrap!<cr>
let s:custom_wrap_mode = 0

fun! ToggleWrapMode()
    if s:custom_wrap_mode
        unmap j
        unmap k
        set nowrap
        let s:custom_wrap_mode = 0
    else
        nnoremap j gj
        nnoremap k gk
        set wrap
        let s:custom_wrap_mode = 1
    endif
endfun

nnoremap <silent> <Leader>w :call ToggleWrapMode()<cr>


"splits
set splitbelow
set splitright

"move between buffers
nnoremap <Leader>n :bn<cr>
nnoremap <Leader>p :bp<cr>

"swap between buffers with space tab
nnoremap <Leader><Tab> :b#<cr>

"toggle search highlighting
nnoremap <silent> <Leader>/ :set hls!<cr>

"toggle line numbers
nnoremap <silent> <Leader>l :set nu!<cr>

nnoremap <silent> <Leader>g :Goyo <cr>

"easier commenting, when in visual mode cursor will return
nmap <c-_> <Plug>NERDCommenterInvert
vmap <c-_> <Plug>NERDCommenterInvert;gv <Esc>
nmap <Leader>ci <Plug>NERDCommenterInvert
vmap <Leader>ci <Plug>NERDCommenterInvert <Esc>


"============================
"=          Colors          =
""============================

" Enable true color support
if (has("termguicolors"))
    set termguicolors
endif

" Set up colors based on environment
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    colorscheme one
    set background=dark

    " Custom background color for One theme
    if exists('g:colors_name') && g:colors_name ==# 'one'
        call one#highlight('Normal', '', '191c1f', '')
        call one#highlight('Cursor', '', '272d36', '')
    endif
else
    colorscheme jellybeans
    highlight GitGutterAdd    guifg=#009900 ctermfg=2 ctermbg=236
    highlight GitGutterChange guifg=#bbbb00 ctermfg=3 ctermbg=236
    highlight GitGutterDelete guifg=#ff2222 ctermfg=9 ctermbg=236
    highlight SignColumn ctermbg=233 guibg=#151515
endif

"============================
"=        Functions         =
"============================

"trim trailing white space
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun

command! TrimWhitespace call TrimWhitespace()

nnoremap <silent> <Leader>t :TrimWhitespace<cr>
