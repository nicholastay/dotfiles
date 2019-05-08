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
"  Compilation
autocmd FileType tex inoremap <F5> <Esc>:w<Enter>:!latexmk<space>-pdf<space><c-r>%<Enter>
autocmd FileType tex nnoremap <F5> :w<Enter>:!pdflatex<space><c-r>%<Enter>
"  Code
autocmd FileType tex inoremap ;eq <Enter>\begin{equation*}<Enter><Enter>\end{equation*}<Enter><++><Esc>2ki<Tab>
autocmd FileType tex inoremap ;al <Enter>\begin{align*}<Enter><Enter>\end{align*}<Enter><++><Esc>2ki<Tab>
autocmd FileType tex inoremap ;eqn <Enter>\begin{align}<Enter><Enter>\end{align}<Enter><++><Esc>2ki<Tab>
autocmd FileType tex inoremap ;aln <Enter>\begin{align}<Enter><Enter>\end{align}<Enter><++><Esc>2ki<Tab>
autocmd FileType tex inoremap ;it \textit{}<++><Esc>T{i
autocmd FileType tex inoremap ;em \emph{}<++><Esc>T{i
autocmd FileType tex inoremap ;bf \textbf{}<++><Esc>T{i
autocmd FileType tex inoremap ;mx \begin{bmatrix*}<Enter><Enter><++><Esc>2k$i<Tab>
autocmd FileType tex inoremap ;chap \chapter{}<Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;sec \section{}<Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;ssec \subsection{}<Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;sssec \subsubsection{}<Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;tt \texttt{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ;nc \newcommand{}[<++>]{<++>}<Esc>2T{i
autocmd FileType tex inoremap ;ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ;ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ;li <Enter>\item<Space>
autocmd FileType tex inoremap ;ref \ref{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ;env \begin{}<Enter><++><Enter>\end{<++>}<Enter><++><Esc>3k$i
autocmd FileType tex inoremap <C-J> <space>\\<CR>

"  Python
autocmd FileType python inoremap <F5> <Esc>:w<Enter>:!python<space><c-r>%<Enter>
autocmd FileType python nnoremap <F5> :w<Enter>:!python<space><c-r>%<Enter>
