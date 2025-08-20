#!/usr/bin/env bash

set -euco pipefail

if [ "$(whoami)" == "root" ]; then
   echo "This script must NOT be run as root." 1>&2
   exit 1
fi


# [[[cog
# import cog
# import hashlib
# with open(cog.inFile) as f: txt = f.read()
# idx=txt.find('\n# [[[end')
# txt=txt[idx:]
# txt=txt[txt.find('\n', 1):]
# h = hashlib.new('sha256')
# h.update(txt[idx:].encode())
# cog.outl(f"HASH='{h.hexdigest()}'")
# ]]]
# HASH='031edd7d41651593c5fe5c006fa5752b37fddff7bc4e843aa6af0c950f4b9406' # (generated)
# # [[[end]]]

# sudo apt install -y ansible git
# sudo ansible-pull -v -U https://github.com/imochoa/ansible-playbooks.git

# --private-key
# -v

# sudo apt -y install entr ansible git

# # while true; do
# #   ls -d src/*.py | entr -d ./setup.py
# # done

# sudo ansible-playbook ./local.yml
# sudo ansible-pull -v -U https://github.com/imochoa/ansible-playbooks.git



# if [ ! -d ansible-babun-bootstrap ]
#  then
#   git clone https://github.com/tiangolo/ansible-babun-bootstrap.git
# else
#   cd ansible-babun-bootstrap
#   git pull
#   cd ..
# fi

# source ansible-babun-bootstrap/ansible-babun-bootstrap.sh

OS=$(uname | tr '[:upper:]' '[:lower:]')

printf "Detected OS: %s\n" "${OS}";

if [ "${OS}" = "darwin" ]; then
  echo "Running on macOS"

#!/bin/bash
# script to bootstrap setting up a macos with ansible

# # NB: be sure to use system python3
# /usr/bin/pip3 install ansible --user
# export PATH="$HOME/Library/Python/3.9/bin:$PATH"
# installdir="/tmp/laptop-$RANDOM"
# mkdir $installdir

# git clone https://github.com/mdzhang/laptop.git $installdir
# if [ ! -d $installdir ]; then
#     echo "failed to find laptop."
#     echo "git clone failed"
#     exit 1
# else
#     cd $installdir
#     make run
# fi
# echo "cleaning up..."
# rm -Rfv /tmp/$installdir
# echo "done."
# exit 0

elif [  "${OS}" = "linux" ]; then
  echo "Running on Linux"


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
# installdir="/tmp/laptop-$RANDOM"
# mkdir $installdir
# git clone https://github.com/mdzhang/laptop.git $installdir
# if [ ! -d $installdir ]; then
#     echo "failed to find laptop."
#     echo "git cloned failed"
#     exit 1
# else
#     cd $installdir
#     export PATH=$PATH:~/.local/bin
#     make run
# fi

# echo "cleaning up..."
# rm -Rfv /tmp/$installdir
# echo "done."
# exit 0

fi
