# Nick's .zshrc
# idk what i'm doing so yeah.

# Setup the prompt (PS1)
PS1="%F{014}%n%f%F{243}@%f%F{176}%m%f%F{243}:%f%~ » "


# Historys
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=1000


# Some misc options
setopt auto_cd
setopt share_history


# Load zsh completion
# Use menu driven tab completion
zstyle ':completion:*' menu select
eval "$(dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
autoload -Uz compinit && compinit


# Use vim keys
bindkey -v
KEYTIMEOUT=1

# Use beam cursor
# Code 6 for static (not blinking), also for all new prompts, do this too
_beam_cursor() { echo -ne '\e[6 q' ;}
precmd_functions+=(_beam_cursor)

# Update correct cursors for zsh vi editing (from luke's)
# Except use 2 & 6 for statics
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[6 q"
}
zle -N zle-line-init


# Load our common aliases
[ -f $HOME/.config/aliasrc ] && source $HOME/.config/aliasrc

# Finally any local non-VCS configs
[ -f $HOME/.config/localrc ] && source $HOME/.config/localrc


# Syntax highlighting plugin
# Must be loaded last
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Add some color changes from the default green (to lighter)
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=114,underline
ZSH_HIGHLIGHT_STYLES[precommand]=fg=114,underline
ZSH_HIGHLIGHT_STYLES[arg0]=fg=114
