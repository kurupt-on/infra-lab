#!/usr/bin/env bash

set -euo pipefail

. "$( dirname "$0" )/../.env.host"

script="${HP_DIR}/answer/post-install.sh"
key="${HOME}/.ssh/infra_lab_ed25519"
a_cfg="${HP_DIR}/../ansible/ansible.cfg"

create_key() {
    if [[ ! -f "${key}" ]];then
        ssh-keygen -t ed25519     \
                   -C "infra-lab" \
		   -N "" \
                   -f "${key}" \
		   -q
    fi
}

export_key() {
    sed -i "s#__pub__#$( cat "${key}.pub" )#" "${script}"
} 

ansible_cfg() {
    sed -i "s#__pkf__#"${key}"#" "${a_cfg}"
}

create_key
export_key
ansible_cfg

printf "%-20s OK\n" "SSH-KEY"
