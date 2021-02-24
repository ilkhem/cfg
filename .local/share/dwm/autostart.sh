#!/bin/sh

# Helper function that checks if a command is already running
function runonce() {
        pgname=$(echo "$1" | awk '{print $1}')
        pgrep -u $USER -x $pgname > /dev/null || $1
}

# Commands that need to run in the background
runonce "picom" &
runonce "setbg" &
runonce "dwmblocks" &
runonce "powerkit" &
runonce "lxpolkit" &

# Commands that are only run once
autorandr -c --default default &
remaps &
