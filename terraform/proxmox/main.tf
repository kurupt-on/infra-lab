provider "proxmox" {
  endpoint = var.proxmox_endpoint
  insecure = true

  api_token = var.proxmox_api_token
}

module "containers" {
  source = "./containers"

  node_name = var.node_name
  template = var.template
}
