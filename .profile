# nick's .profile

export PATH=$PATH:/usr/local/texlive/2020/bin/x86_64-linux:$HOME/.scripts/tools:$HOME/.scripts/personal:$HOME/.scripts/thirdparty:$HOME/.local/share/npm/bin:$HOME/.local/bin

export MANPATH=$MANPATH:/usr/local/texlive/2020/texmf-dist/doc/man:$HOME/.local/share/npm/share/man
export INFOPATH=$MANPATH:/usr/local/texlive/2020/texmf-dist/doc/info

export LC_TIME=zh_CN.UTF-8

# Note for npm/nodejs
# After install, config with `npm config set prefix "$HOME/.local/share/npm"`, so global
# packages go within our .local path instead of having to sudo (bad)

export NARB_WM="$(cat $HOME/.config/wm)"
export NARB_OVERRIDES="$HOME/.local/narb/host-override"
export NARB_HOST="$(hostname -s)"

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
export LF_ICONS="di=:fi=:ln=:or=:ex=:*.c=:*.cc=:*.clj=:*.coffee=:*.cpp=:*.css=:*.d=:*.dart=:*.erl=:*.exs=:*.fs=:*.go=:*.h=:*.hh=:*.hpp=:*.hs=:*.html=:*.java=:*.jl=:*.js=:*.json=:*.lua=:*.md=:*.php=:*.pl=:*.pro=:*.py=:*.rb=:*.rs=:*.scala=:*.ts=:*.vim=:*.cmd=:*.ps1=:*.sh=:*.bash=:*.zsh=:*.fish=:*.tar=:*.tgz=:*.arc=:*.arj=:*.taz=:*.lha=:*.lz4=:*.lzh=:*.lzma=:*.tlz=:*.txz=:*.tzo=:*.t7z=:*.zip=:*.z=:*.dz=:*.gz=:*.lrz=:*.lz=:*.lzo=:*.xz=:*.zst=:*.tzst=:*.bz2=:*.bz=:*.tbz=:*.tbz2=:*.tz=:*.deb=:*.rpm=:*.jar=:*.war=:*.ear=:*.sar=:*.rar=:*.alz=:*.ace=:*.zoo=:*.cpio=:*.7z=:*.rz=:*.cab=:*.wim=:*.swm=:*.dwm=:*.esd=:*.jpg=:*.jpeg=:*.mjpg=:*.mjpeg=:*.gif=:*.bmp=:*.pbm=:*.pgm=:*.ppm=:*.tga=:*.xbm=:*.xpm=:*.tif=:*.tiff=:*.png=:*.svg=:*.svgz=:*.mng=:*.pcx=:*.mov=:*.mpg=:*.mpeg=:*.m2v=:*.mkv=:*.webm=:*.ogm=:*.mp4=:*.m4v=:*.mp4v=:*.vob=:*.qt=:*.nuv=:*.wmv=:*.asf=:*.rm=:*.rmvb=:*.flc=:*.avi=:*.fli=:*.flv=:*.gl=:*.dl=:*.xcf=:*.xwd=:*.yuv=:*.cgm=:*.emf=:*.ogv=:*.ogx=:*.aac=:*.au=:*.flac=:*.m4a=:*.mid=:*.midi=:*.mka=:*.mp3=:*.mpc=:*.ogg=:*.ra=:*.wav=:*.oga=:*.opus=:*.spx=:*.xspf=:*.pdf="

# Use fcitx as input method
export GTK_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx

# Host-based include
[ -f "$NARB_OVERRIDES/profile.$NARB_HOST" ] && . "$NARB_OVERRIDES/profile.$NARB_HOST"


# startx if tty1 and no wm
[ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ] && exec startx 2&> $HOME/.xoutput


# swap caps on tty if allowed
sudo -n loadkeys $HOME/.local/narb/ttymaps.kmap 2>/dev/null
