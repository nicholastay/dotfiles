#!/bin/sh

# Needed to source the correct stuff first
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Display managers run .xprofile on startup, and
# skip this file. So we just split into that,
# but if startx run we still want to run xprofile.
[ -f ~/.xprofile ] && . ~/.xprofile

#exec dwm
exec bspwm
