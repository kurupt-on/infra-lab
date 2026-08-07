#!/usr/bin/env bash

set -uo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
NETWORK_DIR="$ROOT_DIR/xml/networks"

tput civis
tput sc

for net in virbr0 virbr1; do
    XML="$NETWORK_DIR/${net}.xml"

    if ! virsh net-info "$net" &>/dev/null; then
        virsh net-define "$XML"
    fi

    INFO=$(virsh net-info "$net" 2>/dev/null || true)

    if ! echo "$INFO" | grep -q "Active:.*yes"; then
        virsh net-start "$net"
    fi

    if ! echo "$INFO" | grep -q "Autostart:.*yes"; then
        virsh net-autostart "$net"
    fi
done

tput rc
tput ed
tput cnorm

printf "%-20s OK\n" "CREATE NETWORK"
