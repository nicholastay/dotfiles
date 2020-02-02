# nick's .profile

export PATH=$PATH:/usr/local/texlive/2019/bin/x86_64-linux:$HOME/.scripts/tools:$HOME/.scripts/i3tools:$HOME/.scripts/thirdparty:$HOME/.local/npm/bin:$HOME/.local/bin

export MANPATH=$MANPATH:/usr/local/texlive/2019/texmf-dist/doc/man:$HOME/.local/npm/share/man
export INFOPATH=$MANPATH:/usr/local/texlive/2019/texmf-dist/doc/info

# Note for npm/nodejs
# After install, config with `npm config set prefix "$HOME/.local/npm"`, so global
# packages go within our .local path instead of having to sudo (bad)

# Programs
export EDITOR="nvim"
export TERMINAL="urxvtc"
export BROWSER="firefox"
export FILE="lf"
export READER="zathura"

# Tool configs
export SUDO_ASKPASS="$HOME/.scripts/tools/dpass"
export RANGER_LOAD_DEFAULT_RC=FALSE
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export LF_ICONS="di=:fi=:ln=:or=:ex=:*.c=:*.cc=:*.clj=:*.coffee=:*.cpp=:*.css=:*.d=:*.dart=:*.erl=:*.exs=:*.fs=:*.go=:*.h=:*.hh=:*.hpp=:*.hs=:*.html=:*.java=:*.jl=:*.js=:*.json=:*.lua=:*.md=:*.php=:*.pl=:*.pro=:*.py=:*.rb=:*.rs=:*.scala=:*.ts=:*.vim=:*.cmd=:*.ps1=:*.sh=:*.bash=:*.zsh=:*.fish=:*.tar=:*.tgz=:*.arc=:*.arj=:*.taz=:*.lha=:*.lz4=:*.lzh=:*.lzma=:*.tlz=:*.txz=:*.tzo=:*.t7z=:*.zip=:*.z=:*.dz=:*.gz=:*.lrz=:*.lz=:*.lzo=:*.xz=:*.zst=:*.tzst=:*.bz2=:*.bz=:*.tbz=:*.tbz2=:*.tz=:*.deb=:*.rpm=:*.jar=:*.war=:*.ear=:*.sar=:*.rar=:*.alz=:*.ace=:*.zoo=:*.cpio=:*.7z=:*.rz=:*.cab=:*.wim=:*.swm=:*.dwm=:*.esd=:*.jpg=:*.jpeg=:*.mjpg=:*.mjpeg=:*.gif=:*.bmp=:*.pbm=:*.pgm=:*.ppm=:*.tga=:*.xbm=:*.xpm=:*.tif=:*.tiff=:*.png=:*.svg=:*.svgz=:*.mng=:*.pcx=:*.mov=:*.mpg=:*.mpeg=:*.m2v=:*.mkv=:*.webm=:*.ogm=:*.mp4=:*.m4v=:*.mp4v=:*.vob=:*.qt=:*.nuv=:*.wmv=:*.asf=:*.rm=:*.rmvb=:*.flc=:*.avi=:*.fli=:*.flv=:*.gl=:*.dl=:*.xcf=:*.xwd=:*.yuv=:*.cgm=:*.emf=:*.ogv=:*.ogx=:*.aac=:*.au=:*.flac=:*.m4a=:*.mid=:*.midi=:*.mka=:*.mp3=:*.mpc=:*.ogg=:*.ra=:*.wav=:*.oga=:*.opus=:*.spx=:*.xspf=:*.pdf="

# Other
export BATTERY="BAT0"


# Any local no VCS profile includes
[ -f $HOME/.config/localprofile ] && . $HOME/.config/localprofile


# startx if tty1 and no i3
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx
