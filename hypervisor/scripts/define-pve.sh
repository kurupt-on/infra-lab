#!/usr/bin/env bash

set -euo pipefail

# shellcheck source=../.env.host
. "$( dirname "$0" )/../.env.host"

virsh define "${PVE_XML}" &>/dev/null

printf "%-20s OK\n" "DEFINE PVE"
