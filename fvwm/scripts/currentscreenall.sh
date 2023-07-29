#!/bin/sh

screen1=($(xrandr | awk '{gsub(" primary", ""); print}' | awk -F'[ +]' '$0 ~ /+/ {print $1,$3, $4}' | awk 'NF>=2{print $0}' | head -n 1))
screen2=($(xrandr | awk '{gsub(" primary", ""); print}' | awk -F'[ +]' '$0 ~ /+/ {print $1,$3, $4}' | awk 'NF>=2{print $0}' | tail -n 1))

# figure out which screen is to the right of which
if [ ${screen1[2]} -eq 0  ]; then
    right=(${screen2[@]});
    left=(${screen1[@]});
else
    right=(${screen1[@]});
    left=(${screen2[@]});
fi

# "window" gets the screen the focused window is on
# "mouse" gets the screen the cursor is on
# "taskbar" gets the screen the taskbar is on
case $1 in
    "window")
        pos=$(xwininfo -id $(xdotool getactivewindow) | awk 'NR==4{print $NF}');
        ;;
    "mouse")
        pos=$(xdotool getmouselocation --shell | awk 'NR==1{print substr ($1, 3)}')
        ;;
    "taskbar")
        pos=$(xwininfo -name MainPanel | awk 'NR==4{print $NF}')
        ;;
esac

# if there is a second argument "other"
# then echo the dimensions of the other screen
case $2 in
    "other")
        if [ "$pos" -gt "${right[2]}" ]; then
            echo "${left[1]}";
            exit 1;
        else
            echo "${right[1]}"
            exit 1;
        fi
        ;;
    "y")
        if [ "$pos" -gt "${right[2]}" ]; then
            echo "${right[1]}" | awk 'BEGIN {FS="x"} {print $1}';
            exit 1;
        else
            echo "${left[1]}" | awk 'BEGIN {FS="x"} {print $1}';
            exit 1;
        fi
        ;;
esac

# which screen is this window displayed in? if $pos
# is greater than the offset of the rightmost screen,
# then the window is on the right-hand one
if [ "$pos" -gt "${right[2]}" ]; then
    echo "${right[1]}";
    exit 1;
else
    echo "${left[1]}";
    exit 1;
fi
