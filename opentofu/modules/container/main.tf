terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">=0.120"
    }
  }
}

locals {
  default_hostname     = "ct-${var.vm_id}"
  default_ipv4_address = "${cidrhost("${var.initialization.ip_config.ipv4.gateway}/24", var.vm_id)}/24"
}

resource "proxmox_virtual_environment_container" "this" {
  node_name   = var.node_name
  vm_id       = var.vm_id
  description = var.description
  tags        = concat(["terraform"], var.tags)

  unprivileged  = var.unprivileged
  start_on_boot = var.start_on_boot

  cpu {
    architecture = var.cpu.architecture
    cores        = var.cpu.cores
  }

  memory {
    dedicated = var.memory.dedicated
    swap      = var.memory.swap
  }

  disk {
    datastore_id = var.disk.datastore_id
    size         = var.disk.size
  }

  features {
    nesting = var.features.nesting
    keyctl  = var.features.keyctl
  }

  operating_system {
    template_file_id = var.operating_system.template_file_id
    type             = var.operating_system.type
  }

  initialization {
    hostname = coalesce(var.initialization.hostname, local.default_hostname)

    ip_config {
      ipv4 {
        address = coalesce(var.initialization.ip_config.ipv4.address, local.default_ipv4_address)
        gateway = var.initialization.ip_config.ipv4.gateway
      }
    }

    dns {
      domain  = var.initialization.dns.domain
      servers = var.initialization.dns.servers
    }

    user_account {
      keys = var.initialization.user_account.keys
    }
  }

  network_interface {
    name = "eth0"
  }
}
