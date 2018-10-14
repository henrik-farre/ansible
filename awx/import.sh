#!/bin/bash

# Fix common errors:
# Referencing undefined variables (which default to "")
# Ignoring failing commands
set -o nounset
set -o errexit
set -o pipefail
# Note this breaks passing a variable as args to a command
IFS=$'\n\t'

if [[ ! -f ~/.tower_cli.cfg ]]; then
    echo "missing ~/.tower_cli.cfg"
    exit 1
fi

ansible-playbook provision.yml -D --ask-vault-pass

for ITEM in credential_type notification_template inventory_script inventory project job_template workflow; do
    echo "Importing $ITEM"
    tower-cli send "export/${ITEM}.json"
done

ansible-playbook cleanup.yml -D
