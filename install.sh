#!/usr/bin/env bash

set -e

CONSUL_VERSION=1.10.1

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y zip curl

cd /tmp
curl -sSL  https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip > consul.zip
unzip consul.zip
sudo chmod +x consul
sudo mv consul /usr/bin
consul --version

sudo groupadd --system hashi
sudo useradd -s /sbin/nologin --system -g hashi hashi

sudo mkdir -p /var/lib/consul
sudo chown -R hashi:hashi /var/lib/consul
sudo chmod -R 775 /var/lib/consul

sudo mkdir -p /etc/consul.d
sudo mv consul.hcl /etc/consul.d/
sudo chown -R hashi:hashi /etc/consul.d
sudo mv consul.service /etc/systemd/system/
sudo systemctl enable consul

sudo rm -rf /tmp/*
cat /dev/null > ~/.bash_history
history -c
