module "ct_101_samba" {
  source = "./modules/container"

  node_name   = "vidro"
  description = <<-EOT
    # samba
    Manage file sharing via Samba.

    ### Configs
    OpenTofu: [ct_101_samba.tf](https://git.vidro.renaism.com/renaism/vidro/src/branch/main/opentofu/ct_101_sambar.tf)

    Ansible: [ct_101_samba.yml](https://git.vidro.renaism.com/renaism/vidro/src/branch/main/ansible/playbooks/ct_101_samba.yml)
    EOT
  vm_id       = 101
  tags        = ["os.debian", "service.single", "type.storage"]

  start_on_boot = true

  cpu = {
    cores = 2
  }

  memory = {
    dedicated = 512
    swap      = 512
  }

  disk = {
    datastore_id = "pve"
    size         = 2
  }

  mount_points = [
    {
      volume = "/mpool/media",
      path   = "/mnt/media"
    }
  ]

  operating_system = {
    template_file_id = proxmox_download_file.tmpl_debian_13.id
    type             = "debian"
  }

  initialization = {
    hostname = "samba"
    user_account = {
      keys = [var.ansible_ssh_public_key]
    }
  }
}
