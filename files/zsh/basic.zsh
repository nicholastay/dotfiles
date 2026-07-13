# Some extra stuff that is not as managed by the nix syntax.

PROMPT="%F{006}%n%f%F{243}@%f%F{013}%m%f%F{243}:%f%(5~|%-1~/…/%3~|%4~)%f » "
# ... SSH prefix.
[ ! -z $SSH_CLIENT ] && PROMPT="(SSH) $PROMPT"

bindkey '^K' autosuggest-execute


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
bindkey '^[^?' backward-kill-word
bindkey '^[^H' backward-kill-word # iterm - 'send hex codes: 0x1b 0x08' on alt+bksp
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
