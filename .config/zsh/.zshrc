#
# Nick's .zshrc
#
# idk what i'm doing so yeah, let's have some fun :)
#

# Setup the prompt (PS1) - override possibility for extras so more is set below
NT_PROMPT_BASE="%F{006}%n%f%F{243}@%f%F{013}%m%f%F{243}:%f%(5~|%-1~/…/%3~|%4~)"

# Simplify prompt in some cases...
# ... linux TTY (zsh is our default shell, annoying if gets in way of debug).
[ "$TERM" = "linux" ] && PS1="%F{cyan}%n%f%F{white}@%f%F{magenta}%m%f%F{white}:%f%(5~|%-1~/…/%3~|%4~)$ " && LC_TIME=en_AU.UTF-8
# ... SSH.
[ ! -z $SSH_CLIENT ] && PS1="(SSH) $PS1"


# Historys
HISTFILE="$HOME/.local/share/zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000


# Some misc options
# Automatically push dirs to stack so we can quickly flip between dirs
setopt auto_pushd
# For above, minus should mean reverse (at least to me?)
setopt pushd_minus
# No repeat history
setopt histignorealldups
# For prompt vars (e.g. VCS if we like)
setopt prompt_subst


# ZSH History stuff - NOTE: less relevant if atuin in use.
# No history duplicates
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
# Save history immediately rather than on exit
setopt INC_APPEND_HISTORY
# Store history including times
setopt EXTENDED_HISTORY


# ZSH Completion
# Use menu driven tab completion
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# Speed up compinit by only checking once a day
autoload -Uz compinit
for dump in $HOME/.cache/zcompdump(N.mh+24); do
	compinit -d "$HOME/.cache/zcompdump"
done
compinit -C -d "$HOME/.cache/zcompdump"

# macOS: Add brew as a spot to also search
[ ! -z "$NT_IS_MACOS" ] && {
	# Completion via brew
	if type brew &>/dev/null; then
	    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
	fi
}

# Use vim keys
bindkey -v
KEYTIMEOUT=1

# Edit command line with $VISUAL
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Vim key fixes
# Backspace in viins
bindkey -v '^?' backward-delete-char
# Ctrl-r
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
# Delete
bindkey '^[[3~' delete-char # xterm
bindkey '^[[P' delete-char # st
# Home/End in vicmd
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line # xterm
bindkey '^[[4~' end-of-line # st
# -- Emacs style keys back in vim mode
# Alt-arrows - prefer per 'word' to be bash-style to hit ends
autoload -U select-word-style
select-word-style bash
bindkey '^[[1;3D' backward-word
bindkey '^[b' backward-word # iterm
bindkey '^[[1;3C' forward-word
bindkey '^[f' forward-word # iterm
bindkey '\e^?' backward-delete-word # iterm
# Move
bindkey '^B' backward-char
bindkey '^F' forward-char
# Begin/end
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
# Various others
bindkey '^U' kill-whole-line
bindkey '^W' backward-kill-word
bindkey '^Y' yank


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
add-zsh-hook -Uz precmd xterm_title_precmd
add-zsh-hook -Uz preexec xterm_title_preexec

# fzf - fuzzy finding in ctrl+r(non-atuin),ctrl+t,alt+c
{
	source /usr/share/fzf/shell/key-bindings.zsh 2>/dev/null || \
	{ command -v fzf >/dev/null && eval "$(fzf --zsh)" ;} # macOS... for now
}

# atuin - use if it's installed for better sqlite completion :)
# (init below fzf so we take the key back)
command -v atuin >/dev/null && {
	# Use sqlite history via atuin, but no up arrow pls
	eval "$(atuin init zsh --disable-up-arrow)"
	# Don't register atuin first because it will hallucinate hard before real completions
	ZSH_AUTOSUGGEST_STRATEGY=(completion atuin history)
}

# Autosuggestion plugin
[ "$TERM" != "linux" ] && {
	source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null \
	|| source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
}
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(completion history)
bindkey '^K' autosuggest-execute


# Load our common aliases
source $HOME/.config/aliasrc
# Load overrides
source $NT_OVERRIDES/zshrc 2>/dev/null

# Finalise prompt after overrides
PROMPT="$NT_PROMPT_BASE$NT_PROMPT_EXTRA%f » "

# Syntax highlighting plugin
# Must be loaded last - don't override colouring in tty
{
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null \
	|| source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
} && \
[ "$TERM" != "linux" ] && \
[ -z "$NT_LIGHT" ] && \
{
	# Add some color changes from the default green (to lighter)
	ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=114,underline
	ZSH_HIGHLIGHT_STYLES[precommand]=fg=114,underline
	ZSH_HIGHLIGHT_STYLES[arg0]=fg=114
}
