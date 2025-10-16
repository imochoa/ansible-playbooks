# https://forum.ansible.com/t/devcontainers-for-ansible-collection-development/3774/2

FROM python:3.13-slim

WORKDIR /home/vscode

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    ssh \
    shfmt \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Ansible and related tools
RUN pip install --no-cache-dir \
    ansible \
    ansible-lint

# RUN ansible-galaxy collection install netscaler.adc -p /usr/share/ansible/collections

# RUN groupadd --gid 1000 vscode \
#     && useradd --uid 1000 --gid 1000 -m vscode \
#     && mkdir -p /home/vscode/.vscode-server/extensions \
#     && chown -R vscode:vscode /home/vscode

# Make sure the non-root user has the rights to use sudo without password
# RUN echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# USER vscode

# # Set environment variables for non-root user
# ENV PATH="/home/vscode/.local/bin:${PATH}"

# ENTRYPOINT ["/bin/bash"]