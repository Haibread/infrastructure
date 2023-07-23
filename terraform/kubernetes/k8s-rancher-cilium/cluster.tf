resource "rancher2_cloud_credential" "vsphere" {
  name = "vsphere-credential"
  vsphere_credential_config {
    username     = var.vsphere_user
    password     = var.vsphere_password
    vcenter      = var.vsphere_vcenter_address
    vcenter_port = var.vsphere_vcenter_port
  }
}

resource "rancher2_machine_config_v2" "master_config" {
  generate_name = "master-node"
  vsphere_config {
    cfgparam      = ["disk.enableUUID=TRUE"]
    cpu_count     = 4
    creation_type = "vm"
    clone_from    = var.cluster_image_name
    datacenter    = "Homelab"
    datastore     = "vsanDatastore"
    //folder = ""
    pool        = "FX2S/Resources"
    memory_size = var.cluster_controlplane_memory
    network     = ["${var.cluster_controlplane_network_name}"]
  }
}

resource "rancher2_cluster_v2" "tfcluster" {
  name                  = var.cluster_name
  kubernetes_version    = var.cluster_kubernetes_version
  enable_network_policy = false
  rke_config {
    machine_pools {
      name                         = "rkepool"
      cloud_credential_secret_name = rancher2_cloud_credential.vsphere.id
      control_plane_role           = true
      etcd_role                    = true
      worker_role                  = true
      quantity                     = 3
      machine_config {
        name = rancher2_machine_config_v2.master_config.name
        kind = rancher2_machine_config_v2.master_config.kind
      }
    }
  }
}
