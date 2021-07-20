#!/usr/bin/env bash

set -e

CONSUL_VERSION=1.10.1
VAULT_VERSION=1.7.3
ENV_CONSUL_VERSION=0.11.0

sudo apt-get update
sudo apt-get install -y zip curl

cd /tmp/files
curl -sSL  https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip > consul.zip
unzip consul.zip
sudo chmod +x consul
sudo mv consul /usr/bin/
consul --version

curl -sSL https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip > vault.zip
unzip vault.zip
sudo chmod +x vault
sudo mv vault /usr/bin/
vault --version

curl -sSL https://releases.hashicorp.com/envconsul/${ENV_CONSUL_VERSION}/envconsul_${ENV_CONSUL_VERSION}_linux_amd64.zip > envconsul.zip
unzip envconsul.zip
sudo chmod +x envconsul
sudo mv envconsul /usr/bin/
envconsul -h

sudo groupadd --system hashi
sudo useradd -s /sbin/nologin --system -g hashi hashi

sudo mkdir -p /var/lib/consul
sudo chown -R hashi:hashi /var/lib/consul
sudo chmod -R 775 /var/lib/consul

sudo mv hashi-env.sh /etc/profile.d/

sudo mkdir -p /etc/consul.d
sudo mv consul.hcl /etc/consul.d/
sudo chown -R hashi:hashi /etc/consul.d
sudo mv consul.service /etc/systemd/system/
sudo systemctl enable consul

sudo mkdir -p /etc/envconsul.d
sudo mv envconsul.hcl /etc/envconsul.d/

sudo mkdir -p /etc/vault.d
sudo mv vault.hcl /etc/vault.d/
sudo chown -R hashi:hashi /etc/vault.d
sudo mv vault.service /etc/systemd/system/
sudo systemctl enable vault

sudo rm -rf /tmp/*
cat /dev/null > ~/.bash_history
history -c
