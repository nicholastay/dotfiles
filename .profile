# nick's .profile

export PATH=$HOME/.local/bin:$HOME/.scripts/personal:$HOME/.scripts/tools:$HOME/.scripts/thirdparty:$HOME/.local/share/npm/bin:/usr/local/texlive/2020/bin/x86_64-linux:$PATH

export MANPATH=$MANPATH:/usr/local/texlive/2020/texmf-dist/doc/man:$HOME/.local/share/npm/share/man
export INFOPATH=$MANPATH:/usr/local/texlive/2020/texmf-dist/doc/info

export LC_TIME=zh_CN.UTF-8

# Note for npm/nodejs
# After install, config with `npm config set prefix "$HOME/.local/share/npm"`, so global
# packages go within our .local path instead of having to sudo (bad)

export NEX_OVERRIDES="$HOME/.local/nex/host-override"
export NEX_HOST="$(hostname -s)"

# Programs
export EDITOR="nvim"
export VISUAL="$EDITOR"
export TERMINAL="alacritty"
export BROWSER="firefox"
export FILE="ranger"
export READER="zathura"
export STATUSBAR="polybar"

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
GTK_IM_MODULE=ibus
QT_IM_MODULE=ibus
XMODIFIERS=@im=ibus

# Host-based include
[ -f "$NEX_OVERRIDES/profile.$NEX_HOST" ] && . "$NEX_OVERRIDES/profile.$NEX_HOST"


# startx if tty1 and no wm
[ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ] && exec startx 2&> $HOME/.xoutput

# swap caps on tty if allowed
sudo -n loadkeys $HOME/.local/nick/ttymaps.kmap 2>/dev/null
