#
# nick's .profile
#
# no, not that dating app profile! the nerd one.
#

# PATH: have my stuff shadow over any local binaries,
export PATH=$HOME/.local/bin:$HOME/.scripts/personal:$HOME/.scripts/tools:$HOME/.scripts/thirdparty:$PATH
# ... but for flatpak, whatever lol (I really don't want to use them when possible)
export PATH=$PATH:/var/lib/flatpak/exports/bin

# for fun
export LC_TIME=zh_CN.UTF-8

[ -z "$NT_HOST" ] && export NT_HOST="$(hostname -s)"
export NT_OVERRIDES="$HOME/.local/ntay/overrides/$NT_HOST"

# cannot check WAYLAND_DISPLAY as it is not ready yet at login
[ "$DESKTOP_SESSION" = "sway" ] && export NT_IS_WAYLAND=1

# detect macos for scripts to leverage
case "$OSTYPE" in
	"darwin"*) export NT_IS_MACOS=1 ;;
esac

# For QT apps to theme properly - make sure qt5ct installed
[ "$DESKTOP_SESSION" != "plasma" ] && export QT_QPA_PLATFORMTHEME=qt5ct

# Programs
export EDITOR="nvim"
export VISUAL="$EDITOR"
export BROWSER="firefox"
export FILE="ranger"
export READER="zathura"

# KDE slop overrides
if [ "$DESKTOP_SESSION" = "plasma" ]; then
	export FILE="dolphin"
fi

# Home dotfiles cleanup
export INPUTRC="$HOME/.config/inputrc"
export LESSHISTFILE="-"
export CARGO_HOME="$HOME/.local/share/cargo"

# Tool configs
export SUDO_ASKPASS="$HOME/.scripts/tools/dpass"
export FZF_DEFAULT_OPTS="--layout=reverse --height 85%"

# Java nonsense
export _JAVA_SETTINGS="-Dswing.aatext=TRUE -Dawt.useSystemAAFontSettings=on" # antialising for swing and default toolkit

# Host-based include
[ -f "$NT_OVERRIDES/profile" ] && . "$NT_OVERRIDES/profile"


# swap caps on tty if allowed
sudo -n loadkeys $HOME/.local/ntay/ttymaps.kmap 2>/dev/null
