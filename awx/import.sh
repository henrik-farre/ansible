#!/bin/bash

# Fix common errors:
# Referencing undefined variables (which default to "")
# Ignoring failing commands
set -o nounset
set -o errexit
set -o pipefail
# Note this breaks passing a variable as args to a command
IFS=$'\n\t'

for ITEM in user organization; do
    echo "$ITEM"
    tower-cli send "${ITEM}.json"
done

# TODO
# settings:
# - baseurl
# user
# - set password

ansible-playbook credentials.yml -D

for ITEM in project inventory job_template; do
    echo "$ITEM"
    tower-cli send "${ITEM}.json"
done

ansible-playbook -i hosts cleanup.yml -D
