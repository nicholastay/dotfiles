# Nick's .bashrc
# Pretty lean, not much really to configure

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Our prompt (user@computer: >>)
PS1="\[\033[38;5;14m\]\u\[$(tput sgr0)\]\[\033[38;5;243m\]@\[$(tput sgr0)\]\[\033[38;5;194m\]\h\[$(tput sgr0)\]\[\033[38;5;243m\]:\[$(tput sgr0)\]\[\033[38;5;15m\]\w » \[$(tput sgr0)\]"

[ ! -z $SSH_CLIENT ] && PS1="(SSH) $PS1"

export HISTFILE="$HOME/.local/share/bash_history"

# cd by name only is ok
shopt -s autocd

# termdir binding
bind '"\C-n": "termdir\C-m"'

# Load our aliases
[ -f $HOME/.config/aliasrc ] && . $HOME/.config/aliasrc

# Load any host-based runs
source sourcehost bashrc
source sourcehost aliasrc
