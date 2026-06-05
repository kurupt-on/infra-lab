provider "proxmox" {
	endpoint = "https://pve.corp.local:8006/"
	insecure = true

	api_token = var.proxmox_api_token
}
