#!/bin/bash
# baraction.sh for spectrwm status bar

## DISK
hdd() {
  hdd="$(df -h | awk 'NR==4{print $3, $5}')"
  echo -e "HDD: $hdd"
}


## RAM
mem() {
  mem=`free | awk '/Mem/ {printf "%dM/%dM\n", $3 / 1024.0, $2 / 1024.0 }'`
  echo -e "$mem"
}


## CPU
cpu() {
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo -e "CPU: $cpu%"
}


## VOLUME
vol() {
    vol=`amixer get Master | awk -F'[][]' 'END{ print $4":"$2 }' | sed 's/on://g'`
    echo -e "VOL: $vol"
}


## BATTERY
bat() {
        BAT=`acpi -b`
        CHARGE=`acpi -b | awk '{printf("%d", $4)}'`
        AC=`acpi -a | awk '{printf("%s", $3)}'`

        #  if AC connected
        if [ "$AC" = 'on-line' ]
            then
        #if battery connected and charging
        # TO DO check
        if [ -n "$BAT" ]
            then
            # TO DO make % green to show charged/ing
            POWER="${CHARGE}%"
        else
            #is only on AC
            POWER="AC"
        fi
        else # hence is not on AC so is discharging battery
                        POWER="${CHARGE}%"

        #		if [ "$CHARGE -gt "20" ]
        #			then
        #			#TO DO make orange for > 20%
        #                        POWER="${CHARGE}%"
        #		else
        #			#TO DO make red for < 20%#                        POWER="${CHARGE}%"
        #		fi
        fi
        echo -e "$POWER"
}




## INTERNET
net() {
        wired_state=`nmcli dev | grep 'ethernet' | awk '{printf ("%s", $3)}'`
        wireless_state=`nmcli dev | grep '^wlo1' | awk '{printf ("%s", $3)}'`

        if [ "$wireless_state" = "connected" ]
                then
                quality=`cat /proc/net/wireless | awk '/wlo1/ {printf("%s", $3)}' | sed 's/\.//'`
                wireless_name=`nmcli con | grep 'wlo1' | awk '{print $1}' `
                if [ "$wired_state" = "connected" ]
                        then
                        wired_name=`nmcli con | grep 'ethernet' | awk '{print $1}'`
                        net="${wired_name} & ${wireless_name} at ${quality}%"
                else
                        net="${wireless_name} at ${quality}%"
                fi
        else
                if [ "$wired_state" = "connected" ]
                        then
            wired_name=`nmcli con | grep 'ethernet' | awk '{print $1}'`
                        net="${wired_name}"
                else
                        net="not connected"
                fi
        fi
        echo -e "$net"
}


## KERNEL
ker() {
        kernel=`uname -r`
        echo -e "$kernel"
}


## SPOTIFY SONG
spot() {
        STATUS=`qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get org.mpris.MediaPlayer2.Player PlaybackStatus`
        if [ "$STATUS" = "Playing" ]
        then
                ARTIST=`qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Metadata | grep xesam:artist | awk -F: '{print $3}'`
                TRACK=`qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Metadata | grep xesam:title | awk -F: '{print $3}'`
                SPOTIFY_NAME="${ARTIST} -${TRACK}"
        else
                SPOTIFY_NAME=""
        fi
        echo -e "$SPOTIFY_NAME"
}



SLEEP_SEC=2
#loops forever outputting a line every SLEEP_SEC secs

# It seems that we are limited to how many characters can be displayed via
# the baraction script output. And the the markup tags count in that limit.
# So I would love to add more functions to this script but it makes the
# echo output too long to display correctly.
while :; do
        echo "+@fg=3; $(spot) +@fg=9; | +@fg=0; +@fn=1;💻+@fn=0; $(cpu) +@fg=9; | +@fg=2; +@fn=1;💾+@fn=0; $(mem) +@fg=9; | +@fg=7; +@fn=1;🌎+@fn=0; $(net) +@fg=9; | +@fg=8; +@fn=1;🔋+@fn=0; $(bat) +@fg=9; | +@fg=4; +@fn=1;🔈+@fn=0; $(vol) +@fg=9; |"
	sleep $SLEEP_SEC
done
