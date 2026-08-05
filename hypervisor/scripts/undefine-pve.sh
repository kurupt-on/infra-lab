#!/usr/bin/env bash

set -euo pipefail

. "$( dirname $0 )/../.env.host"

virsh undefine "${VM}"

printf "VM indefinida\n"
