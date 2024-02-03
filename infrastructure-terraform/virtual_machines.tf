data "vsphere_datacenter" "datacenter" {
  name = "Homelab"
}

data "vsphere_datastore" "vsanDatastore" {
  name          = "vsanDatastore"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "FX2S" {
  name          = "FX2S"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "DPG-Servers-10" {
  name          = "DPG-Servers-10"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_content_library" "ubuntu-cloudimg" {
  name = "ubuntu-cloudimg"
}

data "vsphere_content_library_item" "jammy-server" {
  name       = "jammy-server-cloudimg-amd64"
  type       = "ovf"
  library_id = data.vsphere_content_library.ubuntu-cloudimg.id
}

resource "vsphere_virtual_machine" "test-machine" {
  name             = "test-machine"
  num_cpus         = 1
  memory           = 1024
  resource_pool_id = data.vsphere_compute_cluster.FX2S.resource_pool_id
  datastore_id     = data.vsphere_datastore.vsanDatastore.id
  network_interface {
    network_id = data.vsphere_network.DPG-Servers-10.id
  }
  disk {
    label = "disk0"
    size  = 20
  }
  cdrom {
    client_device = true
  }
  clone {
    template_uuid = data.vsphere_content_library_item.jammy-server.id
    customize {
      # linux_options {
      #   host_name = "test-vm"
      #   domain    = "homelab.lan"
      # }
      network_interface {
        ipv4_address = "10.0.10.2"
        ipv4_netmask = "24"
      }
      ipv4_gateway = "10.0.10.254"
    }
  }
  vapp {
    properties = {
      "public-keys" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9s7RxUz0DkPWRBA6FQjPWdeTy1sC/1LAM4PxHVJ241A7dgvBRIwEcKcLwVs8INPEOc5qxJNJW8OiCy+W/tsLt7MY1NmCaEiN0MZ+4rTnABBQfMubMb3i2SzHt9k/gBvSZT07kIxD2AoTbITHzK2BAdT7KG1HMFM6tKz92KNCriFeMo2SE8tU8KK4IhH4k865mcfxaJRLaikZtQb+5M3jHGsolWg8mjOMgwGpU6NT0rkxYmInShIcZrvLdoAZRMMiNYWDZYiOu51h9VbDIjg14Tku3MTq5Ivl4bsO1Rfjt47AJFsfHQyz759kZSZ4sMoQPNMe7HMc0N4Y7gUUr8oeR haibread"
      "hostname" = "test-vm.homelab.lan"
    }
  }
}
