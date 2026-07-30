#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
NETWORK_DIR="$ROOT_DIR/xml/networks"

for net in virbr0 virbr1; do
    XML="$NETWORK_DIR/${net}.xml"

    if ! virsh net-info "$net" >/dev/null 2>&1; then
        echo "Definindo rede $net..."
        virsh net-define "$XML"
    fi

    if ! virsh net-info "$net" | grep -q "Active:.*yes"; then
        echo "Iniciando rede $net..."
        virsh net-start "$net"
    fi

    if ! virsh net-info "$net" | grep -q "Autostart:.*yes"; then
        echo "Habilitando autostart para $net..."
        virsh net-autostart "$net"
    fi
done

echo
echo "Redes prontas."
virsh net-list --all
