#!/usr/bin/env bash

set -euo pipefail

# shellcheck source=../.env.host
. "$( dirname "$0" )/../.env.host"

iso="${ISO_POOL_DIR}/proxmox.iso"
auto_iso="${ISO_POOL_DIR}/proxmox-auto.iso"

if [[ ! -d "${ISO_POOL_DIR}" ]];then
    mkdir -p "${ISO_POOL_DIR}"
fi

if [[ ! -f "${iso}" && ! -f "${auto_iso}" ]];then
    tput civis
    tput sc
    wget -O "${iso}" https://enterprise.proxmox.com/iso/proxmox-ve_9.2-1.iso
    tput rc
    tput ed
    tput cnorm
fi

printf "%-20s OK\n" "DOWNLOAD ISO"
