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
    source      = "files"
    destination = "/tmp/"
  }
  provisioner "shell" {
    inline = [
      "cd /tmp/files",
      "chmod +x install.sh",
      "./install.sh"
    ]
  }
}
