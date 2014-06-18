#!/bin/sh
ansible-playbook --skip-tags "needs_sudo" -i hosts ${USER}.yml