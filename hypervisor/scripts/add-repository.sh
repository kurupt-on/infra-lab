#!/usr/bin/env bash

set -euo pipefail

if [[ ! -f "/usr/share/keyrings/proxmox-archive-keyring.gpg" ]];then
    tput civis
    tput sc
    wget https://enterprise.proxmox.com/debian/proxmox-archive-keyring-trixie.gpg -O /usr/share/keyrings/proxmox-archive-keyring.gpg 
    tput rc
    tput ed
    tput cnorm
fi

if [[ ! -f "/etc/apt/sources.list.d/proxmox.sources" && ! -f "/etc/apt/sources.list.d/proxmox.sources.bak" ]];then
	cat > /etc/apt/sources.list.d/proxmox.sources << EOF
Types: deb
URIs: http://download.proxmox.com/debian/pve
Suites: trixie
Components: pve-no-subscription
Signed-By: /usr/share/keyrings/proxmox-archive-keyring.gpg
EOF
fi

tput civis
tput sc

apt-get update

tput rc
tput ed
tput cnorm

printf "%-20s OK\n" "ADD REPOSITORY"
