#!/usr/bin/env bash

set -euo pipefail

# shellcheck source=../.env.host
. "$( dirname "$0" )/../.env.host"
HV_DIR=$( cd "$( dirname "$0" )/../" && pwd )

if [[ ! -d "${POOL_ISO_DIR}" ]];then
    mkdir -p "${POOL_ISO_DIR}"
fi

if [[ ! -f "${POOL_ISO_DIR}/proxmox.iso" && ! -f "${POOL_ISO_DIR}/proxmox-auto.iso" ]];then
    tput civis
    tput sc
    wget -O "${POOL_ISO_DIR}/proxmox.iso" https://enterprise.proxmox.com/iso/proxmox-ve_9.2-1.iso
    tput rc
    tput ed
    tput cnorm
fi

printf "%-20s OK\n" "DOWNLOAD ISO"
