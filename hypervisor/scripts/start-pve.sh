#!/usr/bin/env bash

. "$( dirname $0 )/../.env.host"

virt-install \
  --connect qemu:///system \
  --name pve \
  --memory 8192 \
  --vcpus 4 \
  --cpu host-passthrough \
  --machine q35 \
  --boot loader=/usr/share/OVMF/OVMF_CODE_4M.fd,loader.readonly=yes,loader.type=pflash,nvram.template=/usr/share/OVMF/OVMF_VARS_4M.fd \
  --disk vol=infra-lab/pve.qcow2,bus=scsi \
  --controller type=scsi,model=virtio-scsi \
  --network network=default,model=virtio \
  --graphics spice \
  --video virtio \
  --serial pty \
  --console pty,target.type=serial \
  --cdrom /opt/STORAGE/infra-lab/hypervisor/iso/proxmox-ve_9.2-1.iso \
  --osinfo detect=on \
  --noautoconsole
