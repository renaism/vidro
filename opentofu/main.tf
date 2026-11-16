terraform {
  required_version = ">=1.13"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">=0.120"
    }
  }
}

provider "proxmox" {
  endpoint = var.proxmox_endpoint
  # Currently can not set container feature flags when using api token
  # api_token = var.proxmox_api_token
  username = var.proxmox_username
  password = var.proxmox_password
  insecure = true
}
