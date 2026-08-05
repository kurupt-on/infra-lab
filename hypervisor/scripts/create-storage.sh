#!/usr/bin/env bash

set -euo pipefail

. "$( dirname "$0" )/../.env.host"
HV_DIR=$( cd "$( dirname "$0" )/../" && pwd )

clear

if [[ ! -d "${POOL_DIR}" ]];then
    mkdir -p "${POOL_DIR}" &>/dev/null
fi

#if [[ ! -d "${HV_DIR}/storage/${POOL}" ]];then
#    mkdir -p "${POOL_DIR}" &>/dev/null
#fi


if [[ ! -d "${POOL_ISO_DIR}" ]];then
    mkdir -p "${POOL_ISO_DIR}" &>/dev/null
fi

#if [[ ! -L "${HV_DIR}/storage/${POOL_ISO}" ]];then
#    ln -s "${HV_DIR}/iso" "${HV_DIR}/storage/${POOL_ISO}"
#fi

if ! virsh pool-info "$POOL" &>/dev/null ;then
    virsh pool-define-as "$POOL" dir --target "${POOL_DIR}"
    virsh pool-build "$POOL"
    virsh pool-start "$POOL"
    virsh pool-autostart "$POOL"
fi

if ! virsh pool-info "$POOL_ISO" &>/dev/null ;then
    virsh pool-define-as "$POOL_ISO" dir --target "${POOL_ISO_DIR}"
    virsh pool-build "$POOL_ISO"
    virsh pool-start "$POOL_ISO"
    virsh pool-autostart "$POOL_ISO"
fi

if ! virsh vol-info --pool "$POOL" --vol "$DISK" &>/dev/null ;then
    virsh vol-create-as "$POOL" "$DISK" "$DISK_SIZE" --format qcow2
fi

if [[ ! -L "${HV_DIR}/storage/${POOL}" ]];then
    ln -s "${POOL_DIR}" "${HV_DIR}/storage/${POOL}" 
fi

if [[ ! -L "${HV_DIR}/storage/${POOL_ISO}" ]];then
    ln -s "${POOL_ISO_DIR}" "${HV_DIR}/storage/${POOL_ISO}"
fi

clear
printf "Storage criado\n"
echo
