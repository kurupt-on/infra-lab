#!/usr/bin/env bash

set -euo pipefail

tput civis
tput sc

apt-get install -y qemu-system-x86 \
                   qemu-guest-agent \
                   ovmf \
                   libvirt0 \
                   bridge-utils \
                   qemu-utils \
                   libvirt-daemon-system \
                   libvirt-daemon \
                   libvirt-clients \
                   dnsmasq-base \
                   proxmox-auto-install-assistant

tput rc
tput ed
tput cnorm

if [[ -f "/etc/apt/sources.list.d/proxmox.sources" && ! -f "/etc/apt/sources.list.d/proxmox.sources.bak" ]];then
    mv "/etc/apt/sources.list.d/proxmox.sources" "/etc/apt/sources.list.d/proxmox.sources.bak"
fi

apt-get update &>/dev/null

printf "%-20s OK\n" "INSTALL PACKAGES"
