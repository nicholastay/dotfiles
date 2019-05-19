#!/bin/sh

xrdb -merge $HOME/.Xresources

# Autostart stuffs
compton -b -f & # compositor
setwp & # wallpaper
sxhkd & # hotkey daemon
remapkb & # remap keyboard caps esc thing
dunst & # notifs
unclutter & # hides mouse after delay
mpd & # music
mpdscribble & # music last.fm
urxvtd -f & # terminal
ibus-daemon -drx & # CJK IME

exec i3
