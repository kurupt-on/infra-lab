resource "proxmox_virtual_environment_container" "auth" {
  node_name    = var.node_name
  vm_id        = "101"
  unprivileged = true
  started      = true

  features {
    nesting = true
  }

  initialization {
    hostname = "auth"

  user_account {
    keys  = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEh0Il2n62X4e45MRKVcdqLfHRakBhJm5ZSSjc+6Jg9c ansible@corp.local"]
  }

    ip_config {
      ipv4 {
        address = "10.0.0.3/24"
        gateway = "10.0.0.2"
      }
    }
  }

  network_interface {
    name   = "eth0"
    bridge = "vmbr1"
  }

  operating_system {
    template_file_id  = var.template
    type              = "debian" 
  }

  cpu {
    cores = 1
  }

  memory {
    dedicated = 512
    swap      = 512
  }

  disk {
    datastore_id = "local-lvm"
    size         = 8
  }
}

