variable "proxmox_api_token" {
  type      = string
  sensitive = true
}

variable "proxmox_endpoint" {
  type      = string
}

variable "node_name" {
  default   = "pve"
}

variable  "template" {
  default   = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
}

