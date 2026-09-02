#!/usr/bin/env bash

set -euo pipefail

# shellcheck source=../.env.host
. "$( dirname "$0" )/../.env.host"

if virsh net-info --network default &>/dev/null ;then
	virsh net-undefine --network default &>/dev/null
fi

tput civis
tput sc

for net in "virbr0" "virbr1"; do
    xml="$NETWORK_DIR/${net}.xml"

    if ! virsh net-info --network "${net}" &>/dev/null; then
        virsh net-define "$xml"
    fi

    info=$( LC_ALL=C virsh net-info --network "${net}" 2>/dev/null || true)

    if ! echo "${info}" | grep -q "Active:.*yes"; then
        virsh net-start "${net}"
    fi

    if ! echo "${info}" | grep -q "Autostart:.*yes"; then
        virsh net-autostart "${net}"
    fi
done

tput rc
tput ed
tput cnorm

printf "%-20s OK\n" "CREATE NETWORK"
