# nick's .profile

# PATH: have my stuff shadow over any local binaries,
# ... but for flatpak, whatever lol (I really don't want to use them when possible)
export PATH=$HOME/.local/bin:$HOME/.scripts/personal:$HOME/.scripts/tools:$HOME/.scripts/thirdparty:$HOME/.emacs.d/bin:$HOME/.local/share/npm/bin:/usr/local/texlive/2020/bin/x86_64-linux:$PATH:/var/lib/flatpak/exports/bin


export MANPATH=$MANPATH:/usr/local/texlive/2020/texmf-dist/doc/man:$HOME/.local/share/npm/share/man
export INFOPATH=$MANPATH:/usr/local/texlive/2020/texmf-dist/doc/info

export LC_TIME=zh_CN.UTF-8

# Note for npm/nodejs
# After install, config with `npm config set prefix "$HOME/.local/share/npm"`, so global
# packages go within our .local path instead of having to sudo (bad)

export NEX_OVERRIDES="$HOME/.local/nex/host-override"
export NEX_HOST="$(hostname -s)"

# cannot check WAYLAND_DISPLAY as it is not ready yet at login
[ -z $NEX_WAYLAND ] && [ "$DESKTOP_SESSION" = "sway" ] && export NEX_WAYLAND=1

# Programs
export EDITOR="nvim"
export VISUAL="$EDITOR"
export BROWSER="firefox"
[ "$DESKTOP_SESSION" != "plasma" ] && export FILE="ranger" || export FILE="dolphin"
export READER="zathura"
if [ -z "$NEX_WAYLAND" ]; then
	export TERMINAL="alacritty"
	export STATUSBAR="polybar"
else
	export TERMINAL="foot"

	# For QT apps to theme properly - make sure qt5ct installed
	[ "$DESKTOP_SESSION" != "plasma" ] && export QT_QPA_PLATFORMTHEME=qt5ct
fi

# Home dotfiles cleanup
export INPUTRC="$HOME/.config/inputrc"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export RXVT_SOCKET="$HOME/.cache/urxvtd"
export WGETRC="$HOME/.config/wget/wgetrc"
export ZDOTDIR="$HOME/.config/zsh"
export VIMINIT=":source $HOME/.config/nvim/init.vim"
export CARGO_HOME="$HOME/.local/share/cargo"

# Tool configs
export SUDO_ASKPASS="$HOME/.scripts/tools/dpass"
export FZF_DEFAULT_OPTS="--layout=reverse --height 85%"
export _JAVA_AWT_WM_NONREPARENTING=1 # bspwm/dwm are nonreparenting
export _JAVA_SETTINGS="-Dswing.aatext=TRUE -Dawt.useSystemAAFontSettings=on" # antialising for swing and default toolkit

# non-English :)
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# Host-based include
[ -f "$NEX_OVERRIDES/profile.$NEX_HOST" ] && . "$NEX_OVERRIDES/profile.$NEX_HOST"


# startx if tty1 and no wm and no dm
if [ -z $DISPLAY ] && [ "$XDG_SESSION_TYPE" = "tty" ] && [ "$(tty)" = "/dev/tty1" ]; then
	[ -z $NEX_WAYLAND ] \
		&& exec startx 2&> $HOME/.xoutput
		|| exec sway 2&> $HOME/.wloutput
fi

# swap caps on tty if allowed
sudo -n loadkeys $HOME/.local/nick/ttymaps.kmap 2>/dev/null
