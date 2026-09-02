#!/usr/bin/env bash

set -euo pipefail

# shellcheck source=../.env.host
. "$( dirname "$0" )/../.env.host"

iso="${ISO_POOL_DIR}/proxmox.iso"
out="${ISO_POOL_DIR}/proxmox-auto.iso"
answer="${HP_DIR}/answer/answer.toml"
link="${HP_DIR}/iso/proxmox-auto.iso"
post="${HP_DIR}/answer/post-install.sh"

if [[ ! -f "${out}" ]];then
    tput civis
    tput sc
    proxmox-auto-install-assistant prepare-iso \
        "${iso}" \
        --fetch-from iso \
        --answer-file "${answer}" \
        --on-first-boot "${post}" \
        --output "${out}" 

    tput rc
    tput ed
    tput cnorm

    rm "${iso}"
fi

if [[ ! -d "${HP_DIR}/iso" ]];then
    mkdir "${HP_DIR}/iso"
fi
if [[ ! -L "${link}" ]];then
    ln -s "${out}" "${link}"
fi

printf "%-20s OK\n" "CREATE AUTO-ISO"
