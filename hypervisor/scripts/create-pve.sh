#!/usr/bin/env bash

set -euo pipefail

. "$( dirname $0 )/../.env.host"

clear

[ ! -d "${POOL_DIR}" ] || printf "Criando diretório do storage\n" || mkdir -p "$POOL_DIR" &>/dev/null

echo

if ! virsh pool-info "$POOL" &>/dev/null ;then
    printf "Criando storage pool\n"
    echo

    virsh pool-define-as "$POOL" dir --target "$POOL_DIR"
    virsh pool-build "$POOL"
    virsh pool-start "$POOL"
    virsh pool-autostart "$POOL"
fi

if ! virsh vol-info --pool "$POOL" --vol "$DISK" &>/dev/null ;then
    printf "Criando volume\n"
    echo
    virsh vol-create-as "$POOL" "$DISK" "$DISK_SIZE" --format qcow2
fi

printf "Pronto\n"
echo
