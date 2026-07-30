#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$ROOT_DIR/xml"

virsh dumpxml pve > "$ROOT_DIR/xml/pve.xml"

echo "XML exportado para $ROOT_DIR/xml/pve.xml"
