#!/usr/bin/env bash

set -euo pipefail

. "$( dirname $0 )/../.env.host"
HV_DIR=$( cd "$( dirname $0 )/../" && pwd )

if [[ ! -f "${HV_DIR}/iso/proxmox.iso" ]];then
    printf "ok1"
    if [[ ! -d "${POOL_ISO_DIR}" ]];then
        mkdir -p "${POOL_ISO_DIR}"
    fi
    printf "ok2"
    wget -O "${POOL_ISO_DIR}/proxmox.iso" https://enterprise.proxmox.com/iso/proxmox-ve_9.2-1.iso
    printf "ok3"
    ln -s "${POOL_ISO_DIR}/proxmox.iso" "${HV_DIR}/iso/proxmox.iso"
    printf "ok4"
fi


