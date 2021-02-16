#!/bin/sh

function runonce() {
        pgname=$(echo "$1" | awk '{print $1}')
        pgrep -u $USER -x $pgname > /dev/null || $1
}

runonce "picom" &
runonce "setbg" &
runonce "dwmblocks" &
runonce "powerkit" &
runonce "xcape -e Caps_Lock=Escape" &
runonce "lxsession" &
