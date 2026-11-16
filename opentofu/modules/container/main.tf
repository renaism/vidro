terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">=0.120"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.9"
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
    nesting = var.feautres.nesting
    keyctl  = var.feautres.keyctl
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
      keys     = var.initialization.user_account.keys
      password = coalesce(var.initialization.user_account.password, random_password.user_account.result)
    }
  }

  network_interface {
    name = "eth0"
  }
}

resource "random_password" "user_account" {
  length           = 16
  override_special = "_%@"
  special          = true
}
