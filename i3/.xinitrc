#!/bin/sh

xrdb -merge ~/.Xresources
xset r rate 200 50 # repeat rate
setxkbmap -option caps:escape # caps is escape
exec i3
