#!/usr/bin/env bash

set -euo pipefail

for net in virbr1 virbr0; do
    virsh net-destroy "${net}" &>/dev/null || true
    virsh net-undefine "${net}" &>/dev/null || true
done

printf "%-20s OK\n" "DESTROY NETWORK"
