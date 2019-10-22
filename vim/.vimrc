"
" --------------
" nick's vimrc
" --------------
"


"  ------------------------------------------------------------------------
"  Use vim-plug for plugin management!
"  :PlugInstall / :PlugUpdate for stuffs
"  ---------------------

" Auto download for new installs
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load/get the plugins
call plug#begin('~/.vim/plugged')

" Colour scheme
Plug 'danilo-augusto/vim-afterglow'

" Some core things we want
Plug 'tpope/vim-commentary' " Commenting ('gcc')
Plug 'tpope/vim-surround' " Quoting
Plug 'tpope/vim-sleuth' " Indent autodetect

" Additional nice things
Plug 'itchyny/lightline.vim' " A light statusline
Plug 'junegunn/goyo.vim' " Nice centre thing
Plug 'ctrlpvim/ctrlp.vim' " Use ctrl+p for fuzzy files

" More heavy, IDE-like stuff
" Autocompletion + snippets (coc) - run the following:
"     - :CocInstall coc-python coc-bibtex coc-texlab coc-ultisnips
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'honza/vim-snippets' " The actual snippets


" Syntax stuff
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'kovetskiy/sxhkd-vim'
Plug 'lervag/vimtex'
Plug 'harenome/vim-mipssyntax'
call plug#end()



" -------------------------------------------------------------------------
"  Let's go!
"  ---------------------
"  Basics
let mapleader=";"

set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber

set nohlsearch
set splitbelow splitright " why isn't this the default?

colorscheme afterglow


"  Tabs - 4 wide
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4

"  Mouse - dont kill me pls
set mouse=a

"  Autowrites
autocmd BufWritePost *Xresources,*Xdefaults !xrdb -merge %



" ----------------------
"  Plugin config

"  lightline
set laststatus=2
let g:lightline = { 'colorscheme': 'jellybeans', }

"  coc.nvim
"  Tab/S-Tab for completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"



" ----------------------
"  Bindings
"  Fullscreen for prose
map <leader>f :Goyo \| set linebreak<CR>

" Jump to a placeholder character
map <leader><leader> <Esc>/<++><Enter>"_c4l
nnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
inoremap <leader><leader> <Esc>/<++><Enter>"_c4l

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

"  Replace All
nnoremap S :%s//g<Left><Left>

" Read tex files properly
autocmd BufRead,BufNewFile *.tex set filetype=tex



" ---------------------
"  Language specific 'Macros'

"  LaTeX
autocmd FileType tex nnoremap <F5> :w<Enter>:!latexmk<space>-pdf<space><c-r>%<Enter>
autocmd FileType tex nnoremap <F4> :w<Enter>:!latexmk<space>-xelatex<space><c-r>%<Enter>
autocmd FileType tex nnoremap <F6> :!$READER<space>%:r.pdf<space>&<CR><CR>


" --------------------
" Colour scheme transparency at the end!
hi! Normal ctermbg=NONE guibg=NONE
hi! LineNr ctermbg=NONE guibg=NONE
hi! StatusLine ctermbg=NONE ctermfg=DarkCyan cterm=NONE
