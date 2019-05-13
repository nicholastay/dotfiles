" nick's vimrc
" again probably snagged some of luke's stuffs

" use plug for plugin management
" :PlugInstall / :PlugUpdate for stuffs
" auto download for new installs
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" get the plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'lervag/vimtex'
Plug 'dylanaraps/wal.vim'
call plug#end()
colorscheme wal
let g:deoplete#enable_at_startup = 1

" -------------------------------------------------------------------------
"  Let's go!
"  ---------------------
"  Basics
let mapleader=" "

set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber

set splitbelow splitright " why isn't this the default?

"  Tabs - 4 wide
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4

"  Autocomplete
set wildmode=longest,list,full

" dont kill me pls
set mouse=a

" ----------------------
"  Bindings
"  Fullscreen for prose
map <leader>f :Goyo \| set linebreak<CR>

" Jump to a placeholder character
map <Space><Tab> <Esc>/<++><Enter>"_c4l
nnoremap ;; <Esc>/<++><Enter>"_c4l
inoremap ;; <Esc>/<++><Enter>"_c4l

"  Splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"  System clipboard management
"  Copy + paste
vnoremap <C-c> "+y
map <C-v> "+P

"  Paste mode
set pastetoggle=<F12>

map <F6> :!$READER<space>%:r.pdf<space>&<CR><CR>


" ---------------------
"  'Macros'
"  Replace All
nnoremap S :%s//g<Left><Left>

"  LaTeX
autocmd FileType tex inoremap <F5> <Esc>:w<Enter>:!latexmk<space>-pdf<space><c-r>%<Enter>
autocmd FileType tex nnoremap <F5> :w<Enter>:!pdflatex<space><c-r>%<Enter>

"  Python
autocmd FileType python inoremap <F5> <Esc>:w<Enter>:!python<space><c-r>%<Enter>
autocmd FileType python nnoremap <F5> :w<Enter>:!python<space><c-r>%<Enter>
