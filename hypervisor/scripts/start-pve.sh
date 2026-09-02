#!/usr/bin/env bash

# shellcheck source=../.env.host
. "$( dirname "$0" )/../.env.host"

tput civis
tput sc

printf "\t%s\n" "Aguarde a auto-instalação do Proxmox."

virsh start --domain "${VM}"

while true; do
    if [[ "$( LC_ALL=C virsh domstate "${VM}" )" == "shut off" ]];then
        virsh change-media "${VM}" sdb --eject --config &>/dev/null
        virsh start "${VM}" &>/dev/null
        break
    fi
done

tput rc
tput ed
tput cnorm

printf "%-20s OK\n" "START PVE"
