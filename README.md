# mac todos

# for talon...

defaults write com.apple.finder AppleShowAllFiles true
killall Finder

homebrew is not the recommended way to install podman on mac
https://podman.io/docs/installation#macos

https://iterm2.com/documentation-shell-integration.html

softwareupdate --install-rosetta

# TODO

LANG to /Users/imochoa/.zprofile
export LANG=en_US.UTF-8

# ansible vault

## Files

```
# encrypts in-place!
ansible-vault encrypt --vault-password-file ./secrets/pass.txt file.txt


# feed the pass.txt when running
ansible-playbook -i inventory.yaml --vault-password-file ./secrets/pass.txt playbook.yaml
```

## Vars

https://docs.ansible.com/ansible/2.8/user_guide/playbooks_vault.html#encrypt-string
https://docs.ansible.com/ansible/2.8/cli/ansible-vault.html#ansible-vault-encrypt-string

```
# encrypts in-place!

# with --output, all other vars are deleted...
ansible-vault encrypt_string --vault-password-file ./secrets/pass.txt --name testvar --output ./roles/unix/vars/main.yml ./roles/unix/vars/main.yml

# feed the pass.txt when running
ansible-playbook -i inventory.yaml --vault-password-file ./secrets/pass.txt playbook.yaml
```

# Set values before calling?

-e, --extra-vars

    set additional variables as key=value or YAML/JSON, if filename prepend with @. This argument may be specified multiple times.

--extra-vars "@some_file.json"
--extra-vars "@some_file.Yaml"

# https://www.talkingquickly.co.uk/2021/01/macos-setup-with-ansible/

# https://github.com/geerlingguy/mac-dev-playbook

# mac and ubuntu

# https://github.com/mdzhang/laptop

```bash
sudo apt install -y curl

# TODO check shebang?
curl -sL "https://raw.githubusercontent.com/imochoa/ansible-playbooks/refs/heads/master/bootstrap.sh" | /bin/bash

```
