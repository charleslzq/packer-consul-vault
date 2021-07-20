# shellcheck shell=sh

export CONSUL_HTTP_ADDR=127.0.0.1:8500
export VAULT_ADDR=http://127.0.0.1:8200
alias ec="envconsul -config \"/etc/consul.d/envconsul.hcl\""
