#! /bin/bash
picom &
libinput-gestures-setup start &
nitrogen --restore &
dunst &
nm-applet &
xmodmap ~/.Xmodmap &
/usr/bin/emacs --daemon &
powerkit &
