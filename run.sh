#!/bin/sh

if [ "$(whoami)" == "root" ]; then
   echo "This script must NOT be run as root." 1>&2
   exit 1
fi

ansible-playbook --ask-sudo-pass -i hosts $@ ${USER}.yml
