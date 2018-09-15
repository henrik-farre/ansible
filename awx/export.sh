#!/bin/bash

# Fix common errors:
# Referencing undefined variables (which default to "")
# Ignoring failing commands
set -o nounset
set -o errexit
set -o pipefail
# Note this breaks passing a variable as args to a command
IFS=$'\n\t'

for ITEM in organization user team credential_type credential notification_template inventory_script inventory project job_template workflow; do
    echo $ITEM
    tower-cli receive --${ITEM} all > "${ITEM}.json" || true
done
