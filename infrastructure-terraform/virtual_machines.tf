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
  resource_pool_id = data.vsphere_compute_cluster.FX2S.id
  datastore_id     = data.vsphere_datastore.vsanDatastore.id
  network_interface {
    network_id = data.vsphere_network.DPG-Servers-10.id
  }
  disk {
    label = "disk0"
    size  = 20
  }
  clone {
    template_uuid = data.vsphere_content_library_item.jammy-server.id
    customize {
      network_interface {
        ipv4_address = "10.0.10.2"
        ipv4_netmask = "24"
      }
      ipv4_gateway = "10.0.10.254"
    }
  }
}
