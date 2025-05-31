#!/usr/bin/env zsh

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
HASH='031edd7d41651593c5fe5c006fa5752b37fddff7bc4e843aa6af0c950f4b9406' # (generated)
# [[[end]]]

sudo apt install -y ansible git
sudo ansible-pull -v -U https://github.com/imochoa/ansible-playbooks.git

# --private-key
# -v

# if [ ! -d ansible-babun-bootstrap ]
#  then
#   git clone https://github.com/tiangolo/ansible-babun-bootstrap.git
# else
#   cd ansible-babun-bootstrap
#   git pull
#   cd ..
# fi

# source ansible-babun-bootstrap/ansible-babun-bootstrap.sh

