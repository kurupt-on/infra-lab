#!/usr/bin/env bash

. "$( dirname $0 )/../.env.host"

if [[ "$( LC_ALL=C virsh domstate --domain "${VM}" )" == "running" ]];then
	virsh shutdown --domain "${VM}" &>/dev/null

	printf "%-20s OK\n" "STOP PVE"
fi
