#!/bin/bash

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f ~/.xprofile ] && . ~/.xprofile

export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus

eval "$(dbus-launch --sh-syntax --exit-with-session)"

fcitx -d -r -s 5 &

sleep 10 && redshift -m randr -t 5800:4600 -l 24.46:118.1 -g 0.9:1:1 -P > /tmp/redshift.log 2>&1 &

exec fvwm3

