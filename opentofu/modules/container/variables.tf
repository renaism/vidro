variable "node_name" {
  type    = string
  default = "vidro"
}

variable "description" {
  type    = string
  default = "Managed by Terraform"
}

variable "vm_id" {
  type = number

  validation {
    condition     = var.vm_id >= 100 && var.vm_id <= 254 && var.vm_id % 1 == 0
    error_message = "The vm_id value must be an integer from 100 to 254."
  }
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "unprivileged" {
  type    = bool
  default = true
}

variable "start_on_boot" {
  type    = bool
  default = false
}

variable "cpu" {
  type = object({
    architecture = optional(string, "amd64")
    cores        = optional(number, 1)
  })
  default = {}
}

variable "memory" {
  type = object({
    dedicated = optional(number, 512)
    swap      = optional(number, 512)
  })
  default = {}
}

variable "disk" {
  type = object({
    datastore_id = optional(string, "pve")
    size         = optional(number, 2)
  })
  default = {}
}

variable "feautres" {
  type = object({
    nesting = optional(bool, true)
    keyctl  = optional(bool, true)
  })
  default = {}
}

variable "operating_system" {
  type = object({
    template_file_id = string
    type             = string
  })
}

variable "initialization" {
  type = object({
    hostname = optional(string)
    ip_config = optional(object({
      ipv4 = object({
        address = optional(string)
        gateway = optional(string, "192.168.0.1")
      })
    }), { ipv4 = {} })
    dns = optional(object({
      domain  = optional(string)
      servers = optional(list(string))
    }), {})
    user_account = optional(object({
      keys     = optional(list(string))
      password = optional(string)
    }), {})
  })
  default = {}
}
