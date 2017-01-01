#!/bin/bash

ansible-playbook -i hosts.ini bootstrap.yml --limit workstation
