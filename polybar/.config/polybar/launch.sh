#!/bin/sh

# Kill current bars
killall -q polybar

# Wait for processes to be killed
while pgrep -x polybar >/dev/null; do sleep 1; done

# Spawn a bar for every display
for mon in $(polybar -m | awk -F: '{ print $1 }'); do
	MONITOR=$mon polybar main &
done

echo "Polybar OK"
