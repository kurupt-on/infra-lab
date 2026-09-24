#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$( dirname "$0" )

printf "=================================\n"
printf "%-20s %s\n" "TASK" "STATUS"
printf "=================================\n"

./"${SCRIPT_DIR}/stop-pve.sh"
./"${SCRIPT_DIR}/undefine-pve.sh"
./"${SCRIPT_DIR}/destroy-storage.sh"
./"${SCRIPT_DIR}/destroy-networks.sh"
./"${SCRIPT_DIR}/clean-pve.sh"

printf "=================================\n"
printf "%-20s %s\n\n" "REMOVE ALL" "COMPLETED"
