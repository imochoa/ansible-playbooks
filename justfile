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
  ansible-galaxy install .

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
  sudo $(which ansible-playbook) ./local.yml


# ansible-test sanity --docker