#
# ~/.bash_profile
#

export PATH=$PATH:~/.scripts/tools:~/.scripts/i3tools:~/.local/bin

# Programs
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="firefox"
export FILE="ranger"
export READER="zathura"

# Other
export BATTERY="BAT0"
export SUDO_ASKPASS="$HOME/.scripts/tools/dpass"

[[ -f ~/.bashrc ]] && . ~/.bashrc

# startx if tty1 and no i3
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx
