# Nick's .bashrc
# Pretty lean, not much really to configure

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Our prompt (user@computer: >>)
PS1="\[\033[38;5;6m\]\u\[$(tput sgr0)\]\[\033[38;5;243m\]@\[$(tput sgr0)\]\[\033[38;5;13m\]\h\[$(tput sgr0)\]\[\033[38;5;243m\]:\[$(tput sgr0)\]\[\033[38;5;15m\]\w » \[$(tput sgr0)\]"

[ ! -z $SSH_CLIENT ] && PS1="(SSH) $PS1"

export HISTFILE="$HOME/.local/share/bash_history"

# cd by name only is ok
shopt -s autocd

# Dynamic window title
function settitle () {
    echo -ne "\033]0;$1\007"
}
trap 'settitle "$BASH_COMMAND"' DEBUG
PROMPT_COMMAND='settitle "${USER}@${HOSTNAME}:${PWD/#$HOME/"~"}"'";$PROMPT_COMMAND"

# Load our aliases
[ -f $HOME/.config/aliasrc ] && . $HOME/.config/aliasrc
