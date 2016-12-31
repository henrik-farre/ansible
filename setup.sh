#!/bin/bash

ansible-playbook -i hosts.ini setup.yml --limit localhost
