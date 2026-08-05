#!/usr/bin/env bash

set -euo pipefail

for net in virbr1 virbr0; do
    virsh net-destroy "$net" 2>/dev/null || true
    virsh net-undefine "$net" 2>/dev/null || true
done

clear
printf "Networks destruidas.\n"
echo
