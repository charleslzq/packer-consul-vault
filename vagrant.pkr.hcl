source "vagrant" "consul-vault" {
  communicator = "ssh"
  source_path  = "ubuntu/hirsute64"
  provider     = "virtualbox"
  output_dir   = ".output"
  add_force    = true
}

build {
  sources = ["source.vagrant.consul-vault"]
  provisioner "file" {
    source      = "install.sh"
    destination = "/tmp/install.sh"
  }
  provisioner "file" {
    source      = "consul.hcl"
    destination = "/tmp/consul.hcl"
  }
  provisioner "file" {
    source      = "consul.service"
    destination = "/tmp/consul.service"
  }
  provisioner "file" {
    source      = "vault.hcl"
    destination = "/tmp/vault.hcl"
  }
  provisioner "file" {
    source      = "vault.service"
    destination = "/tmp/vault.service"
  }
  provisioner "shell" {
    inline = [
      "ls -la /tmp",
      "cd /tmp/",
      "chmod +x install.sh",
      "./install.sh"
    ]
  }
}
