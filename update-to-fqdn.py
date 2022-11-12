#!/bin/env python
import glob
import re

yaml_files = glob.glob("**/*.yml", recursive=True)

modules_mapping = {
    r'^(\s*)copy:$': r'\1ansible.builtin.copy:',
    r'^(\s*)apt:$': r'\1ansible.builtin.apt:',
    r'^(\s*)apt_key:$': r'\1ansible.builtin.apt_key:',
    r'^(\s*)apt_repository:$': r'\1ansible.builtin.apt_repository:',
    r'^(\s*)blockinfile:$': r'\1ansible.builtin.blockinfile:',
    r'^(\s*)command:$': r'\1ansible.builtin.command:',
    r'^(\s*)copy:$': r'\1ansible.builtin.copy:',
    r'^(\s*)cron:$': r'\1ansible.builtin.cron:',
    r'^(\s*)debug:$': r'\1ansible.builtin.debug:',
    r'^(\s*)fail:$': r'\1ansible.builtin.fail:',
    r'^(\s*)file:$': r'\1ansible.builtin.file:',
    r'^(\s*)get_url:$': r'\1ansible.builtin.get_url:',
    r'^(\s*)git:$': r'\1ansible.builtin.git:',
    r'^(\s*)group:$': r'\1ansible.builtin.group:',
    r'^(\s*)include_role:$': r'\1ansible.builtin.include_role:',
    r'^(\s*)include_tasks:$': r'\1ansible.builtin.include_tasks:',
    r'^(\s*)include_vars:$': r'\1ansible.builtin.include_vars:',
    r'^(\s*)known_hosts:$': r'\1ansible.builtin.known_hosts:',
    r'^(\s*)lineinfile:$': r'\1ansible.builtin.lineinfile:',
    r'^(\s*)package:$': r'\1ansible.builtin.package:',
    r'^(\s*)pip:$': r'\1ansible.builtin.pip:',
    r'^(\s*)service:$': r'\1ansible.builtin.service:',
    r'^(\s*)service_facts:$': r'\1ansible.builtin.service_facts:',
    r'^(\s*)set_fact:$': r'\1ansible.builtin.set_fact:',
    r'^(\s*)setup:$': r'\1ansible.builtin.setup:',
    r'^(\s*)shell:$': r'\1ansible.builtin.shell:',
    r'^(\s*)stat:$': r'\1ansible.builtin.stat:',
    r'^(\s*)systemd:$': r'\1ansible.builtin.systemd:',
    r'^(\s*)template:$': r'\1ansible.builtin.template:',
    r'^(\s*)unarchive:$': r'\1ansible.builtin.unarchive:',
    r'^(\s*)uri:$': r'\1ansible.builtin.uri:',
    r'^(\s*)user:$': r'\1ansible.builtin.user:',
}

#  yaml_files = ["roles/sudo/tasks/main.yml"]

for file_name in yaml_files:
    try:
        with open(file_name, "r") as in_file:
            data = in_file.read()
            for search, replace in modules_mapping.items():
                data = re.sub(search, replace, data, flags=re.M)

        with open(file_name, "w") as out_file:
            out_file.write(data)

    except Exception as e:
        print(f"ERROR {e}")
