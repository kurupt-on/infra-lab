#!/bin/bash

set -euxo pipefail

update-ca-certificates
systemctl enable ssh
systemctl restart ssh
