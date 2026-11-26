module "ct_100_netbird" {
  source = "./modules/container"

  node_name   = "vidro"
  description = <<-EOT
    # netbird
    Exit node for a NetBird network.

    ### Configs
    OpenTofu: [ct_100_netbird.tf](https://git.vidro.renaism.com/renaism/vidro/src/branch/main/opentofu/ct_100_netbird.tf)

    Ansible: [ct_100_netbird.yml](https://git.vidro.renaism.com/renaism/vidro/src/branch/main/ansible/playbooks/ct_100_netbird.yml)
    EOT
  vm_id       = 100
  tags        = ["os.debian", "service.single", "type.network"]

  start_on_boot = true

  cpu = {
    cores = 1
  }

  memory = {
    dedicated = 512
    swap      = 512
  }

  disk = {
    datastore_id = "pve"
    size         = 2
  }

  operating_system = {
    template_file_id = proxmox_download_file.tmpl_debian_13.id
    type             = "debian"
  }

  initialization = {
    hostname = "netbird"
    user_account = {
      keys = [var.ansible_ssh_public_key]
    }
  }
}
