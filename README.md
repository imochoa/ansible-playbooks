# mac todos
defaults write com.apple.finder AppleShowAllFiles true
killall Finder

https://iterm2.com/documentation-shell-integration.html

# Bootstrap
1. pull github repo? `sudo apt install -y git`
2. Install ansible `sudo apt install -y ansible`

sudo ansible-pull -U https://github.com/<org>/repo.git

ansible-pull -v -U https://github.com/imochoa/ansible-playbooks.git --ask-become-pass

Continue:
https://www.youtube.com/watch?v=sn1HQq_GFNE
22:45

# Set values before calling?
-e, --extra-vars

    set additional variables as key=value or YAML/JSON, if filename prepend with @. This argument may be specified multiple times.
--extra-vars "@some_file.json"
--extra-vars "@some_file.Yaml"


# Semaphore UI

# https://github.com/olivomarco/my-ansible-linux-setup

# Ansible pull with private Github
https://medium.com/planetarynetworks/ansible-pull-with-private-github-repository-d147fdf6f60b


# Sources
# https://www.talkingquickly.co.uk/2021/01/macos-setup-with-ansible/
# https://github.com/geerlingguy/mac-dev-playbook
# mac and ubuntu
# https://github.com/mdzhang/laptop
