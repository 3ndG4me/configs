call plug#begin('~/.vim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'

call plug#end()

let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
colorscheme onedark
syntax on

set paste
set tabstop=4
set softtabstop=4
set expandtab
set number
set cursorline
set showmatch
set incsearch
set hlsearch

" Keymaps
let mapleader=";"
nnoremap <Leader>t :NERDTreeFocus<CR>
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Tab> <C-w>w
