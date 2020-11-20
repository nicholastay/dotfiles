#!/bin/sh

# Kill current bars
killall -q polybar

# Wait for processes to be killed
while pgrep -x polybar >/dev/null; do sleep 1; done

# Left module for wm
[ -z "$POLYBAR_MODULES_LEFT" ] && export POLYBAR_MODULES_LEFT="xwindow"
export POLYBAR_MODULES_LEFT="$NARB_WM $POLYBAR_MODULES_LEFT"

# Spawn a bar for every display
for mon in $(polybar -m | awk -F: '{ print $1 }'); do
	MONITOR=$mon polybar main &
done

echo "Polybar OK"
