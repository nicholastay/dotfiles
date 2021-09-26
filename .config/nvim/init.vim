"
" --------------
" nick's vimrc
" --------------
"


"  ------------------------------------------------------------------------
"  Use vim-plug for plugin management!
"  :PlugInstall / :PlugUpdate for stuffs
"  ---------------------

if !has("nvim")
  set runtimepath+=~/.config/nvim
endif

" Auto download for new installs
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load/get the plugins
call plug#begin('~/.config/nvim/plugged')

" Colour scheme
Plug 'danilo-augusto/vim-afterglow'

" Some core things we want (thanks tpope :^))
Plug 'tpope/vim-commentary' " Commenting ('gcc')
Plug 'tpope/vim-surround' " Quoting
Plug 'tpope/vim-sleuth' " Indent autodetect
Plug 'tpope/vim-vinegar' " netrw improvements

" Additional nice things
Plug 'itchyny/lightline.vim' " A light statusline
Plug 'mengelbrecht/lightline-bufferline' " Buffers as tabs
Plug 'junegunn/goyo.vim' " Nice centre thing

" Let's try autocompletion...
" ... but only load it if we are really doing dev (to avoid slow loads)
if $NARB_NVIM_DEV != ""
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

Plug 'deoplete-plugins/deoplete-jedi'

" More 'bloaty' plugins can go here...
Plug 'ctrlpvim/ctrlp.vim' " Use ctrl+p for fuzzy files
Plug 'jiangmiao/auto-pairs' " Pair quotes/brackets/etc automatically
endif


" Syntax stuff
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'kovetskiy/sxhkd-vim'
Plug 'lervag/vimtex'
"Plug 'harenome/vim-mipssyntax'
call plug#end()





" -------------------------------------------------------------------------
"  Let's go!
"  ---------------------
"  Basics
let mapleader="\\"

set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber

set nohlsearch
set splitbelow splitright " why isn't this the default?
set scrolloff=6

"   Colour scheme
"   Always patch our overrides on scheme load
"   https://github.com/junegunn/goyo.vim/issues/84#issuecomment-156299446
function! s:transparent_bg_force()
  hi! Normal ctermbg=NONE guibg=NONE
  hi! LineNr ctermbg=NONE guibg=NONE
  hi! StatusLine ctermbg=NONE ctermfg=DarkCyan cterm=NONE
endfunction
autocmd! ColorScheme afterglow call s:transparent_bg_force()
colorscheme afterglow

"  Tabs - 4 wide
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4

"  Mouse - dont kill me pls
set mouse=a

"  Autowrites
autocmd BufWritePost *Xresources,*Xdefaults !xrdb -merge %

set conceallevel=2



" ----------------------
"  Plugin config

"  lightline
set laststatus=2
let g:lightline = {
  \ 'colorscheme': 'jellybeans',
  \ 'tabline': {
  \   'left': [ ['buffers'] ],
  \   'right': [ ['close'] ]
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers'
  \ },
  \ 'component_type': {
  \   'buffers': 'tabsel'
  \ }
  \ }
let g:lightline#bufferline#show_number = 2

"  use vimtex latex
let g:tex_flavor = 'latex'

" Tab complete
if $NARB_NVIM_DEV != ""
  inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
endif


" ----------------------
"  Bindings
"  Fullscreen for prose
map <leader>f :Goyo \| set linebreak<CR>

" Jump to a placeholder character
map <leader><leader> <Esc>/<++><Enter>"_d4lzzi
nnoremap <leader><leader> <Esc>/<++><Enter>"_d4lzzi
inoremap <leader><leader> <Esc>/<++><Enter>"_d4lzzi

"  Splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"  System clipboard management
"  Copy + paste
vnoremap <leader>c "+y
vnoremap <leader>x "*y
map <leader>v "+P

"  Paste mode
set pastetoggle=<F12>

"  Replace All
nnoremap S :%s//g<Left><Left>

"  Nice little helper for saving sudo when forget
cmap w!! w !sudo tee >/dev/null %

"  Buffer stuff
set showtabline=2
set hidden
"  Switching buffers
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)
nmap <Leader>c1 <Plug>lightline#bufferline#delete(1)
nmap <Leader>c2 <Plug>lightline#bufferline#delete(2)
nmap <Leader>c3 <Plug>lightline#bufferline#delete(3)
nmap <Leader>c4 <Plug>lightline#bufferline#delete(4)
nmap <Leader>c5 <Plug>lightline#bufferline#delete(5)
nmap <Leader>c6 <Plug>lightline#bufferline#delete(6)
nmap <Leader>c7 <Plug>lightline#bufferline#delete(7)
nmap <Leader>c8 <Plug>lightline#bufferline#delete(8)
nmap <Leader>c9 <Plug>lightline#bufferline#delete(9)
nmap <Leader>c0 <Plug>lightline#bufferline#delete(10)
"  Buffer standard
nmap <Leader>t :enew<cr>
nmap <Leader>h :bprevious<cr>
nmap <Leader>l :bnext<cr>
" Close and move to previous one ('close tab')
nmap <Leader>w :bp <BAR> bd #<CR>
" Edit file
nmap <Leader>e :e<space>
" ctrl p buffers
nmap <Leader>q :CtrlPBuffer<cr>
nmap <Leader>z :ls<cr>

" Move lines up/down with alt-j/k
" https://vim.fandom.com/wiki/Moving_lines_up_or_down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv


"  Read tex files properly
autocmd BufRead,BufNewFile *.tex set filetype=tex



" ---------------------
"  Language specific 'Macros'

"  LaTeX
autocmd FileType tex nnoremap <F5> :w<Enter>:!latexmk<space>-pdf<space><c-r>%<Enter>
autocmd FileType tex nnoremap <S-F5> :w<Enter>:!latexmk<space>-xelatex<space><c-r>%<Enter>
autocmd FileType tex nnoremap <F4> :w<Enter>:!texliveonfly<space>--terminal_only<space>-c<space>latexmk<space>-a<space>'-pdf'<space>%<Enter>
autocmd FileType tex nnoremap <F6> :!$READER<space>%:r.pdf<space>&<CR><CR>
