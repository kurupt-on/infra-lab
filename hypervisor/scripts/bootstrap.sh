#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$( dirname "$0" )

clear
printf "=================================\n"
printf "%-20s %s\n" "TASK" "STATUS"
printf "=================================\n"

./"${SCRIPT_DIR}/download-pve-iso.sh"
./"${SCRIPT_DIR}/add-repository.sh"
./"${SCRIPT_DIR}/built-auto-iso.sh"
./"${SCRIPT_DIR}/create-storage.sh"
./"${SCRIPT_DIR}/create-networks.sh"
./"${SCRIPT_DIR}/define-pve.sh"
./"${SCRIPT_DIR}/start-pve.sh"

printf "=================================\n"
printf "%-20s %s\n\n" "BOOTSTRAP" "COMPLETED"

