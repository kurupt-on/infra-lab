#!/usr/bin/env bash

set -uo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
NETWORK_DIR="$ROOT_DIR/xml/networks"

for net in virbr0 virbr1; do
    XML="$NETWORK_DIR/${net}.xml"

    if ! virsh net-info "$net" &>/dev/null; then
        virsh net-define "$XML"
    fi

    if ! virsh net-info "$net" | grep -q "Active:.*yes"; then
        virsh net-start "$net"
    fi

    if ! virsh net-info "$net" | grep -q "Autostart:.*yes"; then
        virsh net-autostart "$net"
    fi
done

clear
printf "Networks criadas\n"
echo
