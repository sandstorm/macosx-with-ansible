#!/bin/bash

#
# Forked from https://raw.githubusercontent.com/osxc/xc-boot/master/boot.sh
#

if [ "$(whoami)" == "root" ]; then
   echo "This script must NOT be run as root." 1>&2
   exit 1
fi

ANSIBLE_BINARY="/usr/local/bin/ansible"
ANSIBLE_MINIMUM_VERSION="1.6"

echo "sandstorm installation bootstrap script"
echo "====================="
echo ""
read -p "Continue ? [Enter]"
echo ""
echo ""

if [ ! -f "/Library/Developer/CommandLineTools/usr/bin/clang" ]; then
    echo "XCode Tools Installation"
    echo "------------------------"
    echo ""
    echo "This will open up a modal window ... Get back here when ready !"
    sudo /usr/bin/xcode-select --install
    read -p "Continue ? [Enter]"
    echo ""
    echo ""
fi


which -s brew
if [[ $? != 0 ]] ; then
    echo "Installing homebrew, as it was not found"
    # Install Homebrew
    # https://github.com/mxcl/homebrew/wiki/installation
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "found homebrew, updating it"
    brew update
fi

if [ ! -f "${ANSIBLE_BINARY}" ]; then
  should_install_ansible=true
else
  ansible_correct_version_installed=`${ANSIBLE_BINARY} --version 2>&1 | cut -c 9- | grep "${ANSIBLE_MINIMUM_VERSION}"`

  if [ "${ansible_correct_version_installed}" ]; then
    should_install_ansible=false
  else
    should_install_ansible=true
  fi
fi

if [ "${should_install_ansible}" == true ]; then
  echo "Ansible installation"
  echo "--------------------"
  brew install ansible
  echo "completed!"
fi
