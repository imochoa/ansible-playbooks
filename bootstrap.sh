#!/usr/bin/env bash

set -euo pipefail
# x will print password!

if [ "$(whoami)" == "root" ]; then
   echo "This script must NOT be run as root." 1>&2
   exit 1
fi


# sudo apt install -y ansible git
# sudo ansible-pull -v -U https://github.com/imochoa/ansible-playbooks.git

# --private-key
# -v

# sudo apt -y install entr ansible git


# sudo ansible-playbook ./local.yml
# sudo ansible-pull -v -U https://github.com/imochoa/ansible-playbooks.git



# source ansible-babun-bootstrap/ansible-babun-bootstrap.sh

OS=$(uname | tr '[:upper:]' '[:lower:]')
printf "Detected OS: %s\n" "${OS}";


# works on both Linux & MacOS
#  bootstrapdir=$(mktemp -d 2>/dev/null || mktemp -d -t ' bootstrapdir')

if [[ -f "./bootstrapdir.txt" ]]; then
   bootstrapdir=$(cat "./bootstrapdir.txt");
else
   bootstrapdir=$(mktemp -d --tmpdir bootstrap.XXXXX)
  printf  $bootstrapdir > "./bootstrapdir.txt"
fi

echo ${bootstrapdir};


if [ "${OS}" = "darwin" ]; then
  echo "Running on macOS"

# NB: be sure to use system python3
# /usr/bin/pip3 install ansible --user
# export PATH="$HOME/Library/Python/3.9/bin:$PATH"
#  bootstrapdir="/tmp/laptop-$RANDOM"
# mkdir  $bootstrapdir


elif [  "${OS}" = "linux" ]; then
  echo "Running on Linux";
  sudo apt-get -y install ansible;
#   python-setuptools python3-setuptools python3 python3-wheel python3-dev python3-pip build-essential libpq-dev libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev libffi-dev libssl-dev git make


#!/bin/bash
# script to bootstrap setting up a debian/ubuntu machine with ansible

# Manual steps
# - Grab Firefox KeePassXC-Connector extension
#   - Setup Firefox HTTP proxy: https://nordvpn.com/tutorials/proxy-setup/firefox/
# - Login to Dropbox, Gmail, Firefox, Github
# - Generate SSH key, add to Github
# - Git clone dotfiles, do recursive install
# - Run preinstall script
# - Pick which directories to GNU stow and stow them
# - Run postinstall script
# - Register gpg key: https://gist.github.com/ankurk91/c4f0e23d76ef868b139f3c28bde057fc
# - Switch to dark theme
# - Drag menubar to lefthand side
# - Konsole Breeze theme
# - Key repeat rate to 50 repeat/s, 300ms delay
# - Show date in menubar
# - Show hidden files in file explorer

# sudo apt-get -y install \
#   python-setuptools python3-setuptools python3 python3-wheel python3-dev python3-pip build-essential libpq-dev libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev libffi-dev libssl-dev git make
# pip3 install ansible --user
#  bootstrapdir="/tmp/laptop-$RANDOM"
# mkdir  $bootstrapdir
# git clone https://github.com/mdzhang/laptop.git  $bootstrapdir
# if [ ! -d  $bootstrapdir ]; then
#     echo "failed to find laptop."
#     echo "git cloned failed"
#     exit 1
# else
#     cd  $bootstrapdir
#     export PATH=$PATH:~/.local/bin
#     make run
# fi


fi


if [ ! -d "${bootstrapdir}/repo" ]; then
    # --depth 1
    git clone --branch master -- https://github.com/imochoa/ansible-playbooks.git  "${bootstrapdir}/repo"
    # sudo ansible-pull -U https://github.com/imochoa/ansible-playbooks.git -C master
fi

pushd "${bootstrapdir}/repo"
trap 'popd' RETURN

vault_pass_file="./secrets/pass.txt";

if [ ! -f $vault_pass_file ]; then
    read -s -p "Enter password: " vault_pass
    printf "%s" "${vault_pass}" > "${vault_pass_file}"
else
    vault_pass=$(cat "$vault_pass_file");
fi

printf "going\n";
# printf "$vault_pass";

# -vvv
ansible-playbook ./local.yml --ask-become-pass --vault-password-file ./secrets/pass.txt # --tags "joplin,vscode"

# export PATH=$PATH:~/.local/bin

# echo "cleaning up..."
# rm -Rfv /tmp/ $bootstrapdir
# echo "done."
exit 0
