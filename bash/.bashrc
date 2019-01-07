#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s autocd # cd by dirname
export PS1="\[\033[38;5;14m\]\u\[$(tput sgr0)\]\[\033[38;5;243m\]@\[$(tput sgr0)\]\[\033[38;5;194m\]\h\[$(tput sgr0)\]\[\033[38;5;243m\]:\[$(tput sgr0)\]\[\033[38;5;15m\]\w » \[$(tput sgr0)\]"

alias ls='ls --color=auto --group-directories-first'
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ccat="highlight --out-format=ansi"

# replace vim with nvim
alias vi="nvim"
alias vim="nvim"

# alias
alias p="sudo pacman"
alias pS="sudo pacman -S"
alias sy="systemctl"
alias ssy="sudo systemctl"
alias tz="trizen"
alias tzS="trizen -S"

alias rcp="rsync -vzrh --times --stats --progress --itemize-changes"

alias v="nvim"
alias e="$FILE"
alias r="ranger"
alias g="git"
alias cl="clear"

alias ltp="latexmk -pdf"
alias ltc="latexmk -c"

alias sdn="shutdown now"
alias reb="reboot"

[ -f "$HOME/.shortcuts" ] && source "$HOME/.shortcuts"

texpkg() { tllocalmgr install $1 && sudo texhash ;}
