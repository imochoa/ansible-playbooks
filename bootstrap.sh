#!/usr/bin/env bash

set -euo pipefail
# x will print passwords! But good for debugging

if [ "$(whoami)" == "root" ]; then
  echo "This script must NOT be run as root." 1>&2
  exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "curl could not be found! Please install curl first." 1>&2
  exit 1
fi

OS=$(uname | tr '[:upper:]' '[:lower:]')
printf "Detected OS: %s\n" "${OS}"

# works on both Linux & MacOS
#  bootstrapdir=$(mktemp -d 2>/dev/null || mktemp -d -t ' bootstrapdir')

if [[ -f "./bootstrapdir.txt" ]]; then
  bootstrapdir=$(cat "./bootstrapdir.txt")
else
  bootstrapdir=$(mktemp -d --tmpdir bootstrap.XXXXX)
  printf "%s" "$bootstrapdir" >"./bootstrapdir.txt"
fi

echo "${bootstrapdir}"

# Install ansible

# MacOS
if [ "${OS}" = "darwin" ]; then
  echo "Running on macOS"

  if ! command -v brew >/dev/null 2>&1; then
    echo "homebrew could not be found! Installing homebrew first."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # set up path
    echo >>/Users/imochoa/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>/Users/imochoa/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  brew install ansible

elif [ "${OS}" = "linux" ]; then
  echo "Running on Linux"
  sudo apt-get -y install ansible
#   python-setuptools python3-setuptools python3 python3-wheel python3-dev python3-pip build-essential libpq-dev libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev libffi-dev libssl-dev git make
fi

# Both MacOS & Linux
if [ ! -d "${bootstrapdir}/repo" ]; then
  git clone --branch master --depth 1 -- https://github.com/imochoa/ansible-playbooks.git "${bootstrapdir}/repo"
  # sudo ansible-pull -U https://github.com/imochoa/ansible-playbooks.git -C master
fi

pushd "${bootstrapdir}/repo"
trap 'popd' RETURN

ansible-galaxy install -r "./requirements.yml"

vault_pass_file="./secrets/pass.txt"

# Remove empty vault pass file from a previous failed run
if [ -f "${vault_pass_file}" ] && [ ! -s "${vault_pass_file}" ]; then
  rm "${vault_pass_file}"
fi

# TODO: did not work on MacOS?
# TODO: make vault pass optional
if [ ! -f "${vault_pass_file}" ]; then
  read -r -s -p "Enter Ansible Vault Password:" vault_pass
  printf "%s" "${vault_pass}" >"${vault_pass_file}"
  printf "\n"
else
  printf "Using existing vault password file: %s\n" "${vault_pass_file}"
  vault_pass=$(cat "$vault_pass_file")
fi

printf "See default YAML vars in %s\n" "$(realpath "./default.config.yml")"
printf "Add custom ones YAML vars in %s\n" "$(realpath "./config.yml")"

read -p "Run with defaults? " -n 1 -r
echo # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
  # -vvv
  ansible-playbook ./local.yml --ask-become-pass --vault-password-file ./secrets/pass.txt # --tags "joplin,vscode"
fi

# export PATH=$PATH:~/.local/bin

printf "done!\n"
exit 0
