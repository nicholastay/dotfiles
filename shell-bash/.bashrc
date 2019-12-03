# Nick's .bashrc
# Pretty lean, not much really to configure

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Our prompt (user@computer: >>)
PS1="\[\033[38;5;14m\]\u\[$(tput sgr0)\]\[\033[38;5;243m\]@\[$(tput sgr0)\]\[\033[38;5;194m\]\h\[$(tput sgr0)\]\[\033[38;5;243m\]:\[$(tput sgr0)\]\[\033[38;5;15m\]\w » \[$(tput sgr0)\]"

# cd by name only is ok
shopt -s autocd

# Load our aliases
[ -f $HOME/.config/termalias ] && . $HOME/.config/termalias

# Load any local things if any (not tracked in VCS)
[ -f $HOME/.config/localrc ] && . $HOME/.config/localrc
