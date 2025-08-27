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

ci:
  ansible-lint .

# update-hashes:
#   cog -r -s " # (generated)" ./bootstrap.sh
#   # -c for checksum

run-local:
  # tag filtering is only applied if you supply the --tags option
  # -vvv
  #  -i ./inventory 
  $(which ansible-playbook) ./local.yml  --ask-become-pass --vault-password-file ./secrets/pass.txt # --tags "joplin,vscode"

run-dev:
  $(which ansible-playbook) ./local.yml  --ask-become-pass --vault-password-file ./secrets/pass.txt --tags "dev"