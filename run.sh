#!/bin/sh
ansible-playbook --ask-sudo-pass -i hosts $@ ${USER}.yml