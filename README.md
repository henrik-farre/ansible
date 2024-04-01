# Ansible

Playbooks and roles for setting up ArchLinux on bare metal and Debian VMs

Running using 1password wrapper script for vault password:
`ansible-playbook -i ../inventory.toml setup.yml --limit host --vault-password-file=~/.local/bin/ansible-op-vault -D`
