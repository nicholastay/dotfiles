#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s autocd # cd by dirname
export PS1="\[\033[38;5;14m\]\u\[$(tput sgr0)\]\[\033[38;5;243m\]@\[$(tput sgr0)\]\[\033[38;5;194m\]\h\[$(tput sgr0)\]\[\033[38;5;243m\]:\[$(tput sgr0)\]\[\033[38;5;15m\]\w » \[$(tput sgr0)\]"

# Tool configs
export RANGER_LOAD_DEFAULT_RC=FALSE
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"

# Load our aliases
[ -f $HOME/.config/termalias ] && . $HOME/.config/termalias

# Load any local things if any (not tracked in VCS)
[ -f $HOME/.config/localrc ] && . $HOME/.config/localrc
