#!/usr/bin/env bash

set e

. "$( dirname $0 )/../.env.host"

virsh destroy "$VM" #&>/dev/null || true
virsh undefine "$VM" --nvram #&>/dev/null || true
virsh vol-delete "$DISK" --pool "$POOL" #2>/dev/null
virsh pool-destroy --pool "$POOL" #2>/dev/null
virsh pool-undefine --pool "$POOL" #2>/dev/null
printf "Done\n"
echo
