Vim�UnDo� U�d@���m�e7��V[_��'����ؼ81   }   Y        QUALITY=`cat /proc/net/wireless | awk '/eth1/ {printf("%s", $3)}' | sed 's/\.//'`   K   4      	       	   	   	    _�%    _�                             ����                                                                                                                                                                                                                                                                                                                                                             _�"�     �                   �               5�_�                    b        ����                                                                                                                                                                                                                                                                                                                                                             _�"�    �   b   d          %# below gives the percent used       �   a   c           5�_�                    G   #    ����                                                                                                                                                                                                                                                                                                                                                             _�#�    �   F   H   }      I	WIRELESS_STATE=`nmcli dev | grep 'wireless' | awk '{printf ("%s", $3)}'`5�_�                    G   #    ����                                                                                                                                                                                                                                                                                                                                                             _�$q    �   F   H   }      E	WIRELESS_STATE=`nmcli dev | grep 'wlo1' | awk '{printf ("%s", $3)}'`5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _�$�     �                while true; do5�_�                            ����                                                                                                                                                                                                                                                                                                                                       t          v       _�$�     �   
   u   }   j   	DATE_STR=`date +%d/%m/%y" "%R`       4#---------------------------------------------------   # power output       	BAT=`acpi -b`   ,	CHARGE=`acpi -b | awk '{printf("%d", $4)}'`   (	AC=`acpi -a | awk '{printf("%s", $3)}'`       #  if AC connected   	if [ "$AC" = 'on-line' ]    	        then   $		#if battery connected and charging   		# TO DO check   		if [ -n "$BAT" ]   			then   +			# TO DO make % green to show charged/ing   			POWER="${CHARGE}%"   		else   			#is only on AC   			POWER="AC"   		fi   4	else # hence is not on AC so is discharging battery   *                        POWER="${CHARGE}%"       #		if [ "$CHARGE -gt "20" ]   #			then    #			#TO DO make orange for > 20%   +#                        POWER="${CHARGE}%"   #		else   H#			#TO DO make red for < 20%#                        POWER="${CHARGE}%"   #		fi   	fi       4#---------------------------------------------------   #temperature       +	#TEMP=`acpi -t | awk '{printf("%d", $4)}'`   4	TEMP_STR=`acpi -t | awk '{printf("%d%s", $4,"C")}'`       #	if [ "$TEMP -gt "70" ]   #		then   #		#TO DO make red   =#	        TEMP_STR=`acpi -t | awk '{printf("%d%s", $4,"C")}'`   #	else   =#	        TEMP_STR=`acpi -t | awk '{printf("%d%s", $4,"C")}'`   #	fi       4#---------------------------------------------------   #memory       d	eval $(awk '/^MemTotal/ {printf "MTOT=%s;", $2}; /^MemFree/ {printf "MFREE=%s;",$2}' /proc/meminfo)   	MUSED=$(( $MTOT - $MFREE ))   &	MUSEDPT=$(( ($MUSED * 100) / $MTOT ))   	MEM_STR="${MUSEDPT}%"       4#---------------------------------------------------   	#internet       F	WIRED_STATE=`nmcli dev | grep 'ethernet' | awk '{printf ("%s", $3)}'`   F	WIRELESS_STATE=`nmcli dev | grep '^wlo1' | awk '{printf ("%s", $3)}'`       .        if [ "$WIRELESS_STATE" = "connected" ]                   then   a                QUALITY=`cat /proc/net/wireless | awk '/eth1/ {printf("%s", $3)}' | sed 's/\.//'`   O                WIRELESS_NAME=`nmcli con | grep 'wireless' | awk '{print $1}' `   3                if [ "$WIRED_STATE" = "connected" ]                           then   S                        WIRED_NAME=`nmcli con | grep 'ethernet' | awk '{print $1}'`   M                        NET="${WIRED_NAME} & ${WIRELESS_NAME} at ${QUALITY}%"                   else   =                        NET="${WIRELESS_NAME} at ${QUALITY}%"                   fi           else   3                if [ "$WIRED_STATE" = "connected" ]                           then   >			WIRED_NAME=`nmcli con | grep 'ethernet' | awk '{print $1}'`   +                        NET="${WIRED_NAME}"                   else   +                        NET="Not Connected"                   fi   
        fi       4#---------------------------------------------------   #CPU       P	CPU_FREQ=`cat /proc/cpuinfo| grep 'cpu MHz' | awk '{printf("%d%s", $4,"MHz")}'`       # below gives the percent used   S#	eval $(awk '/^cpu /{print "previdle=" $5 ";prevtotal=" $2+$3+$4+$5 }' /proc/stat)   #        sleep $SLEEP_SEC   S#        eval $(awk '/^cpu /{print "idle=" $5 "; total=" $2+$3+$4+$5 }' /proc/stat)   1#        intervaltotal=$((total-${prevtotal:-0}))   X#        CPU="$((100*( (intervaltotal) - ($idle-${previdle:-0}) ) / (intervaltotal) ))%"       4#---------------------------------------------------   # volume       I	MUTE=`cat /proc/acpi/ibm/volume | grep 'mute' | awk '{printf("%s",$2)}'`       	if [ "$MUTE" = "off" ]   		then   J		VOL=`cat /proc/acpi/ibm/volume | grep 'level' | awk '{printf("%d",$2)}'`   	else   		VOL="MUTE"   	fi5�_�                    }        ����                                                                                                                                                                                                                                                                                                                                       t          v       _�$�    �   |   ~          done5�_�      	              L   )    ����                                                                                                                                                                                                                                                                                                                                       t          v       _�$�    �   K   M   }      G        WIRELESS_NAME=`nmcli con | grep 'wireless' | awk '{print $1}' `5�_�                  	   K   4    ����                                                                                                                                                                                                                                                                                                                                       t          v       _�%    �   J   L   }      Y        QUALITY=`cat /proc/net/wireless | awk '/eth1/ {printf("%s", $3)}' | sed 's/\.//'`5��