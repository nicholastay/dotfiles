#!/bin/sh

# Display managers run .xprofile on startup, and
# skip this file. So we just split into that,
# but if startx run we still want to run xprofile.
[ -f ~/.xprofile ] && . ~/.xprofile

exec i3
