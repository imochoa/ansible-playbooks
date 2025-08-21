set positional-arguments := true

# -e Exit immediately if a command exits with a non-zero status.
# -u Treat unbound variables as an error when substituting.
# -c If set, commands are read from string. This option is used to provide commands that don't come from a file.
# -o pipefail If any command in a pipeline fails, that return code will be used as the return code of the whole pipeline.

set shell := ["bash", "-euco", "pipefail"]

# Open fzf picker
[no-cd]
_default:
    @just --choose

setup:
  ansible-galaxy install -r requirements.yml
  # ansible-galaxy install --roles-path=roles -r requirements.yml

# # Install Ansible collections
# ansible-galaxy collection install -r requirements.yml
# # Install Ansible roles
# ansible-galaxy role install -r requirements.yml
# # Install Python dependencies
# python3 -m pip install --user -r requirements.txt
# # Install Ansible Lint
# python3 -m pip install --user ansible-lint
# # Install Ansible Test
# python3 -m pip install --user ansible-test

ci:
  ansible-lint .

# update-hashes:
#   cog -r -s " # (generated)" ./bootstrap.sh
#   # -c for checksum

run-local:
  # sudo $(which ansible-playbook) ./local.yml
  # tag filtering is only applied if you supply the --tags option
  # -vvv
  #  -i ./inventory 
  $(which ansible-playbook) ./local.yml  --ask-become-pass --vault-password-file ./secrets/pass.txt # --tags "joplin,vscode"


# ansible-test sanity --docker


# # in case you just want to rerun playbook locally
# run:
# 	PATH="$$PATH:~/.local/bin"
# 	ansible-playbook -i inventory playbook.yml -vvv --ask-become-pass

# sshgen:
# 	ssh-keygen -t ed25519 -a 1000 -C "zhang.michelle.d@gmail.com"

# # b/c I always check this out via HTTP during initial setup
# git-remote-ssh:
# 	git remote set-url origin git@github.com:mdzhang/laptop.git
