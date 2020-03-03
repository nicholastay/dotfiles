# Nick's .zshrc
# idk what i'm doing so yeah.

# Setup the prompt (PS1)
PS1="%F{014}%n%f%F{243}@%f%F{176}%m%f%F{243}:%f%~ » "


# Historys
HISTFILE="$HOME/.local/share/zsh_history"
HISTSIZE=1000
SAVEHIST=1000


# Some misc options
setopt auto_cd
setopt share_history
setopt menu_complete
setopt cdable_vars
# Automatically push dirs to stack so we can quickly flip between dirs
setopt auto_pushd
# For above, minus should mean reverse (at least to me?)
setopt pushd_minus


# Load zsh completion
# Use menu driven tab completion
zstyle ':completion:*' menu select
eval "$(dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
autoload -Uz compinit && compinit


# Use vim keys
bindkey -v
KEYTIMEOUT=1
bindkey -v '^?' backward-delete-char
# Ctrl-r needs to be rebound when using vim
bindkey '^R' history-incremental-search-backward

# vi keys for tab complete
zmodload zsh/complist
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history

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


# Dynamic xtitle
# https://wiki.archlinux.org/index.php/Zsh#xterm_title
autoload -Uz add-zsh-hook
function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m:%~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-}:\005{B}%~\005{-}\e\\'
}
function xterm_title_preexec () {
	print -Pn -- '\e]2;' && print -n -- "${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-}:\005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}
if [[ "$TERM" == (screen*|xterm*|rxvt*|tmux*|putty*|konsole*|gnome*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi


# Autosuggestion plugin
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(completion history)
bindkey '^L' autosuggest-accept
bindkey '^K' autosuggest-execute


# termdir binding
bindkey -s '^n' 'termdir\n'


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


# History substring search
# Must be loaded after the syntax highlighting plugin
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# Binds
# Up/down arrows
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# vi mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# Reset search formatting - magenta bg is too jarring
# Instead just use a nice bold
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=bold
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=fg=red,bold
