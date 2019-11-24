#!/bin/sh

# Kill current bars
killall -q polybar

# Wait for processes to be killed
while pgrep -x polybar >/dev/null; do sleep 1; done

polybar main &
polybar second &

echo "Polybar OK"
