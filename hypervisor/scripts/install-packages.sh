#!/usr/bin/env bash

apt-get install -y qemu-system-x86 \
                   ovmf \
                   virtinst \
                   libvirt0 \
                   bridge-utils \
                   qemu-utils \
                   libvirt-daemon-system \
                   libvirt-clients \
                   dnsmasq-base

