#!/usr/bin/env bash

set -euo pipefail
# x will print password!

if [ "$(whoami)" == "root" ]; then
   echo "This script must NOT be run as root." 1>&2
   exit 1
fi


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
fi

if [ ! -d "${bootstrapdir}/repo" ]; then
    # --depth 1
    git clone --branch master --depth 1 -- https://github.com/imochoa/ansible-playbooks.git  "${bootstrapdir}/repo"
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

# -vvv
ansible-playbook ./local.yml --ask-become-pass --vault-password-file ./secrets/pass.txt # --tags "joplin,vscode"

# export PATH=$PATH:~/.local/bin

# echo "cleaning up..."
# rm -Rfv /tmp/ $bootstrapdir
printf "done!\n";
exit 0
