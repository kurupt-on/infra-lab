#!/usr/bin/env bash

. "$( dirname "$0" )/../.env.host"

tput civis
tput sc
virsh start --domain "${VM}"

while true; do
    if [[ "$( virsh domstate "${VM}" )" == "shut off" ]];then
        virsh change-media "${VM}" sdb --eject --config &>/dev/null
        virsh start "${VM}" &>/dev/null
        break
    fi
done

tput rc
tput ed
tput cnorm

printf "%-20s OK\n" "START PVE"
