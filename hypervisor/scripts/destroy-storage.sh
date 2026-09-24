#!/usr/bin/env bash

set -uo pipefail

. "$( dirname "$0" )/../.env.host"

link1="/iso/proxmox-auto.iso"
link2="/storage/iso"
link3="/storage/infra-lab"

virsh vol-delete --pool "${INFRA_POOL}" --vol "${DISK}" &>/dev/null
virsh vol-delete --pool "${ISO_POOL}" --vol "proxmox-auto.iso"  &>/dev/null

for pool in "${INFRA_POOL}" "${ISO_POOL}";do
    virsh pool-destroy --pool "${pool}" &>/dev/null
    virsh pool-undefine --pool "${pool}" &>/dev/null
done

for link in "${link1}" "${link2}"  "${link3}";do
    if [[ -L "${HP_DIR}${link}" ]];then
        rm "${HP_DIR}${link}"
    fi
done

printf "%-20s OK\n" "DESTROY STORAGE"
