#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

desktop="fvwm3"
count=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)



case $desktop in

	fvwm3|/usr/share/xsessions/fvwm3)
    if type "xrandr" > /dev/null; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload mainbar-fvwm3 -c ~/.config/polybar/config.ini &
      done
    else
    polybar --reload mainbar-fvwm3 -c ~/.config/polybar/config.ini &
    fi

	;;

esac
