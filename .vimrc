" Nick's very light vimrc

let mapleader="\\"

set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber

set splitbelow splitright
set scrolloff=6

colorscheme torte

set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4

set mouse=a

" Splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Copy + paste
vnoremap <leader>y "+y
map <leader>p "+P

" Paste mode
set pastetoggle=<F12>

" Replace all
nnoremap S :%s//g<Left><Left>

" Nice little helper for saving sudo when forget
cmap w!! w !sudo tee >/dev/null %

