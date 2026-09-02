#!/usr/bin/env bash

set -euo pipefail

# shellcheck source=../.env.host
. "$( dirname "$0" )/../.env.host"

stg1=( "${HP_DIR}/storage/${INFRA_POOL}" "${INFRA_POOL_DIR}" )
stg2=( "${HP_DIR}/storage/${ISO_POOL}" "${ISO_POOL_DIR}" )

if [[ ! -d "${HP_DIR}/storage" ]];then
    mkdir "${HP_DIR}/storage"
fi

tput civis
tput sc

for p in "${INFRA_POOL_DIR}" "${ISO_POOL_DIR}"; do
    if [[ ! -d "${p}" ]];then
        mkdir -p "${p}" &>/dev/null
    fi
done

for p in "${ISO_POOL}" "${INFRA_POOL}"; do
    if ! virsh pool-info "${p}";then
        [[ "${p}" == "${ISO_POOL}" ]] && d="${ISO_POOL_DIR}" || d="${INFRA_POOL_DIR}"
        virsh pool-define-as "${p}" dir --target "${d}"
        virsh pool-build "${p}"
        virsh pool-start "${p}"
        virsh pool-autostart "${p}"
    fi
done

if ! virsh vol-info --pool "$INFRA_POOL" --vol "$DISK";then
    virsh vol-create-as "$INFRA_POOL" "$DISK" "$DISK_SIZE" --format qcow2
fi

if [[ ! -L "${stg1[0]}" ]];then
    ln -s "${stg1[1]}" "${stg1[0]}" 
fi
if [[ ! -L "${stg2[0]}" ]];then
    ln -s "${stg2[1]}" "${stg2[0]}" 
fi

tput rc
tput ed
tput cnorm

printf "%-20s OK\n" "CREATE STORAGE"
