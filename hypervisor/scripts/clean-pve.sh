#! /usr/bin/env bash

set -eou pipefail

. "$( dirname "$0" )/../.env.host"

script="${HP_DIR}/answer/post-install.sh"
a_cfg="${HP_DIR}/../ansible/ansible.cfg"

#sed -i "14d" "${script}" &>/dev/null || true
sed -i 's/echo "ssh-.*-lab"/echo "__pub__"/' "${script}"

#cat >> "${script}" << EOF
#echo "__pub__" > "/home/ansible/.ssh/authorized_keys"
#EOF

sed -i "s#\(private_key_file\s*=\s*\).*#\1__pkf__#" "${a_cfg}"
