#!/usr/bin/env bash

set -uo pipefail

. "$( dirname $0 )/../.env.host"

virsh destroy "$VM" 2>/dev/null || true
virsh undefine "$VM" --nvram 2>/dev/null || true

virsh vol-delete "$DISK" --pool "$POOL" 2>/dev/null
#virsh vol-delete "proxmox.iso" --pool "${POOL_ISO}" 2>/dev/null

virsh pool-destroy --pool "$POOL" 2>/dev/null
virsh pool-undefine --pool "$POOL" 2>/dev/null

virsh pool-destroy --pool "$POOL_ISO" 2>/dev/null
virsh pool-undefine --pool "$POOL_ISO" 2>/dev/null

clear
printf "Storage destruido\n"
echo
