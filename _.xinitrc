#!/bin/bash

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f ~/.xprofile ] && . ~/.xprofile

export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx

eval "$(dbus-launch --sh-syntax --exit-with-session)"

fcitx &

exec fvwm2
