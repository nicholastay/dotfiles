#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s autocd # cd by dirname
export PS1="\[\033[38;5;14m\]\u\[$(tput sgr0)\]\[\033[38;5;243m\]@\[$(tput sgr0)\]\[\033[38;5;194m\]\h\[$(tput sgr0)\]\[\033[38;5;243m\]:\[$(tput sgr0)\]\[\033[38;5;15m\]\w » \[$(tput sgr0)\]"

export RANGER_LOAD_DEFAULT_RC=FALSE

alias ls='ls --color=auto --group-directories-first'
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ccat="highlight --out-format=ansi"
alias cl="clear"

# replace vim with nvim
alias vi="nvim"
alias vim="nvim"

# alias
alias p="sudo pacman"
alias pS="sudo pacman -S"
alias pR="sudo pacman -R"
alias pQ="pacman -Q"

alias scl="systemctl"
alias sscl="sudo systemctl"
alias scs="systemctl status"

alias y="yay"
alias yS="yay -S"
alias yR="yay -R"

alias rcp="rsync -vzrh --times --stats --progress --itemize-changes"

alias v="nvim"
alias e="$FILE"
alias g="git"
alias cl="clear"

r() { ranger --choosedir="$HOME/.rangerdir" && cd "$(cat "$HOME/.rangerdir")" ;}

alias ltp="latexmk -pdf"
alias ltc="latexmk -c"

alias wscan="nmcli device wifi rescan"

# vi fuzzy file
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
vf() { fzf | xargs -r -I % $EDITOR % ;}

alias sdn="shutdown now"
alias reb="reboot"

# Install latex package
texpkg() { tllocalmgr install $@ && sudo texhash ;}

# copy a template and edit it
templateEdit() {
	[ ! -f "$2" ] && cp "$HOME/Templates/$1" "$2"
	$EDITOR "$2"
}
alias thw="templateEdit mathhw.tex"
alias txm="templateEdit math.tex"

alias cds="cd ~/.scripts"
alias cdf="cd ~/.dotfiles"
alias cfv="$EDITOR ~/.vimrc"
alias cfb="$EDITOR ~/.bashrc"
alias cfi="$EDITOR ~/.config/i3/config"
alias cfo="$EDITOR ~/.config/i3blocks/config"
alias cfs="$EDITOR ~/.config/sxhkd/sxhkdrc"
alias cfr="$EDITOR ~/.config/ranger/rc.conf"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# xterm transparency
[ -n "$XTERM_VERSION" ] && transset-df -m 0.85 --id "$WINDOWID" >/dev/null

# IBus (zh/kr) ime
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
