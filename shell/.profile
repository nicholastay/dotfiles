# nick's .profile

export PATH=$PATH:/usr/local/texlive/2019/bin/x86_64-linux:$HOME/.scripts/tools:$HOME/.scripts/i3tools:$HOME/.scripts/thirdparty:$HOME/.local/bin

export MANPATH=$MANPATH:/usr/local/texlive/2019/texmf-dist/doc/man
export INFOPATH=$MANPATH:/usr/local/texlive/2019/texmf-dist/doc/info

# Programs
export EDITOR="nvim"
export TERMINAL="urxvtc"
export BROWSER="firefox"
export FILE="ranger"
export READER="zathura"

# Tool configs
export SUDO_ASKPASS="$HOME/.scripts/tools/dpass"
export RANGER_LOAD_DEFAULT_RC=FALSE
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"

# Other
export BATTERY="BAT0"


# Any local no VCS profile includes
[ -f $HOME/.config/localprofile ] && . $HOME/.config/localprofile


# startx if tty1 and no i3
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx