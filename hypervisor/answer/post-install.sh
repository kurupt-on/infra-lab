#!/usr/bin/env bash

update-ca-certificates
sed -i '57c\PasswordAuthentication no' "/etc/ssh/sshd_config"
systemctl enable ssh
systemctl restart ssh
apt-get update
apt-get install -y sudo
echo "ansible ALL=(ALL) NOPASSWD:ALL" >> "/etc/sudoers"
useradd -m -s /bin/bash ansible
mkdir /home/ansible/.ssh/
chmod 0700 /home/ansible/.ssh/

echo "__pub__" > "/home/ansible/.ssh/authorized_keys"

chown -R ansible:ansible /home/ansible
