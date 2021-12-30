#!/bin/sh

# Helper function that checks if a command is already running
function runonce() {
        pgname=$(echo "$1" | awk '{print $1}')
        pgrep -u $USER -x $pgname > /dev/null || $1
}

# Commands that run in the background shouldn't be restarted when dwm is restared ---> use runonce
runonce "picom" &
runonce "dwmblocks" &
# runonce "powerkit" &
runonce "lxpolkit" &
runonce "dunst" &
autorandr -c --default default &
setbg &
remaps & # remaps calls xcape with "killall xcape; xcape" so that only one instance is running, even on dwm restart
