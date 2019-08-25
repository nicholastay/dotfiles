# nick's .profile

export PATH=$PATH:/usr/local/texlive/2019/bin/x86_64-linux:~/.scripts/tools:~/.scripts/i3tools:~/.scripts/thirdparty:~/.local/bin

export MANPATH=$MANPATH:/usr/local/texlive/2019/texmf-dist/doc/man
export INFOPATH=$MANPATH:/usr/local/texlive/2019/texmf-dist/doc/info

# Programs
export EDITOR="nvim"
export TERMINAL="urxvtc"
#export BROWSER="firefox"
export BROWSER="qutebrowser"
export BROWSER_SEC="firefox"
export FILE="ranger"
export READER="zathura"

# Other
export BATTERY="BAT0"
export SUDO_ASKPASS="$HOME/.scripts/tools/dpass"


# startx if tty1 and no i3
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx
