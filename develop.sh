sudo apt -y install entr ansible git

# while true; do
#   ls -d src/*.py | entr -d ./setup.py
# done

sudo ansible-playbook ./local.yml
sudo ansible-pull -v -U https://github.com/imochoa/ansible-playbooks.git
