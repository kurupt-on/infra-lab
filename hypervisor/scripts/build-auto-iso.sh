#!/usr/bin/env bash

set -euo pipefail

. "$( dirname "$0" )/../.env.host"
ROOT="$(dirname "$(realpath "$0")")"
ISO="${POOL_ISO_DIR}/proxmox.iso"
OUT="${POOL_ISO_DIR}/proxmox-auto.iso"
ANSWER="$ROOT/../answer/answer.toml"

if [[ ! -f "${POOL_ISO_DIR}/proxmox-auto.iso" ]];then

    tput civis
    tput sc
    proxmox-auto-install-assistant prepare-iso \
        "$ISO" \
        --fetch-from iso \
        --answer-file "$ANSWER" \
        --on-first-boot "$ROOT/../answer/post-install.sh" \
        --output "$OUT" 

    tput rc
    tput ed
    tput cnorm

    rm ${ISO}
fi

if [[ ! -L "${ROOT}/../iso/proxmox-auto.iso" ]];then
    ln -s "${OUT}" "${ROOT}/../iso/proxmox-auto.iso"
fi

printf "%-20s OK\n" "CREATE AUTO-ISO"
