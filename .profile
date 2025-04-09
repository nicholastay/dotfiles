#
# nick's .profile
#
# no, not that dating app profile! the nerd one.
#

# detect type to normalised for scripts to leverage
export NT_OS='unix'
case "$OSTYPE" in
	"darwin"*) export NT_OS='darwin' ;;
	"linux"*) export NT_OS='linux' ;;
esac

# PATH: have my stuff shadow over any local binaries,
export PATH=$HOME/.local/bin:$HOME/.scripts/personal:$HOME/.scripts/tools/$NT_OS:$HOME/.scripts/tools:$HOME/.scripts/guitools:$HOME/.scripts/thirdparty:$PATH
# additional local install packages
export PATH=$HOME/go/bin:$PATH
# ... but for flatpak, etc, whatever lol (I really don't want to use them when possible)
export PATH=$PATH:/var/lib/flatpak/exports/bin

# overrides system: just pull $NT_OVERRIDES/<file> for a good customised time
export NT_HOST="$(hostname -s)"
# set 'forced' file to 'act' as another host. useful for e.g. work laptop -> set as 'work'
[ -f "$HOME/.local/ntay/overrides/_forced" ] && export NT_HOST="$(cat $HOME/.local/ntay/overrides/_forced)"
export NT_OVERRIDES="$HOME/.local/ntay/overrides/$NT_HOST"
# (alternative: pull _current for apps that can't substitute. or symlink into this if we ALWAYS expect an override;
#    i.e. cannot #include, must have a full file. maybe can script with evalfile/envsubst)
[ ! -e "$HOME/.local/ntay/overrides/_current" ] && ln -sf "$NT_OVERRIDES" "$HOME/.local/ntay/overrides/_current"
export NT_SHADOW="$HOME/.local/ntay/shadow"

# macOS extras
[ "$NT_OS" = "darwin" ] && {
	[ -d "/opt/homebrew" ] && eval $(/opt/homebrew/bin/brew shellenv)
	export PATH="${HOMEBREW_PREFIX}/opt/openssl/bin:$PATH"
}

# For QT apps to theme properly - make sure qt5ct installed
[ "$DESKTOP_SESSION" != "plasma" ] && export QT_QPA_PLATFORMTHEME=qt5ct

# Programs
export TERMINAL="kitty"
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
export SUDO_ASKPASS="$HOME/.scripts/guitools/dpass"
export FZF_DEFAULT_OPTS="--layout=reverse --height=85%"
# LS colours
command -v dircolors >/dev/null && eval "$(dircolors)"
command -v gdircolors >/dev/null && eval "$(gdircolors)"  # macOS

# Java nonsense
export _JAVA_SETTINGS="-Dswing.aatext=TRUE -Dawt.useSystemAAFontSettings=on" # antialising for swing and default toolkit

# Host-based include
[ -f "$NT_OVERRIDES/profile" ] && . "$NT_OVERRIDES/profile"
# Private includes
[ -f "$NT_SHADOW/profile" ] && . "$NT_SHADOW/profile"

# Light theme flipbacks (has to come after override to have loaded env)
[ ! -z "$NT_LIGHT" ] && export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=light"

# swap caps on tty if allowed
[ "$TERM" = "linux" ] && sudo -n loadkeys $HOME/.local/ntay/ttymaps.kmap 2>/dev/null
