#!/usr/bin/env bash

set -uo pipefail

. "$( dirname "$0" )/../.env.host"

virsh undefine --domain "${VM}" --nvram &>/dev/null

printf "%-20s OK\n" "UNDEFINE PVE"

