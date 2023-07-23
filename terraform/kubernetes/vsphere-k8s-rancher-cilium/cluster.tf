resource "rancher2_cloud_credential" "vsphere" {
  name = "vsphere-credential"
  vsphere_credential_config {
    username     = var.vsphere_user
    password     = var.vsphere_password
    vcenter      = var.vsphere_vcenter_address
    vcenter_port = var.vsphere_vcenter_port
  }
}

resource "rancher2_machine_config_v2" "controlplane_config" {
  generate_name = "controlplane-node"
  vsphere_config {
    cfgparam      = ["disk.enableUUID=TRUE"]
    cpu_count     = var.cluster_controlplane_cpu
    creation_type = "vm"
    clone_from    = var.cluster_image_name
    datacenter    = var.cluster_vmware_datacenter
    datastore     = var.cluster_vmware_datastore
    pool          = var.cluster_vmware_resource_pool
    memory_size   = var.cluster_controlplane_memory
    network       = ["${var.cluster_controlplane_network_name}"]
  }
}

resource "rancher2_machine_config_v2" "etcd_config" {
  generate_name = "etcd-node"
  vsphere_config {
    cfgparam      = ["disk.enableUUID=TRUE"]
    cpu_count     = var.cluster_etcd_cpu
    creation_type = "vm"
    clone_from    = var.cluster_image_name
    datacenter    = var.cluster_vmware_datacenter
    datastore     = var.cluster_vmware_datastore
    pool          = var.cluster_vmware_resource_pool
    memory_size   = var.cluster_etcd_memory
    network       = ["${var.cluster_etcd_network_name}"]
  }
}

resource "rancher2_machine_config_v2" "worker_config" {
  generate_name = "worker-node"
  vsphere_config {
    cfgparam      = ["disk.enableUUID=TRUE"]
    cpu_count     = var.cluster_worker_cpu
    creation_type = "vm"
    clone_from    = var.cluster_image_name
    datacenter    = var.cluster_vmware_datacenter
    datastore     = var.cluster_vmware_datastore
    pool          = var.cluster_vmware_resource_pool
    memory_size   = var.cluster_worker_memory
    network       = ["${var.cluster_worker_network_name}"]
  }
}

resource "rancher2_cluster_v2" "tfcluster" {
  name                  = var.cluster_name
  kubernetes_version    = var.cluster_kubernetes_version
  enable_network_policy = false
  rke_config {
    machine_pools {
      name                         = "controlplane-pool"
      cloud_credential_secret_name = rancher2_cloud_credential.vsphere.id
      control_plane_role           = true
      etcd_role                    = false
      worker_role                  = false
      quantity                     = var.cluster_controlplane_count
      machine_config {
        name = rancher2_machine_config_v2.controlplane_config.name
        kind = rancher2_machine_config_v2.controlplane_config.kind
      }
    }
    machine_pools {
      name                         = "etcd-pool"
      cloud_credential_secret_name = rancher2_cloud_credential.vsphere.id
      control_plane_role           = false
      etcd_role                    = true
      worker_role                  = false
      quantity                     = var.cluster_etcd_count
      machine_config {
        name = rancher2_machine_config_v2.etcd_config.name
        kind = rancher2_machine_config_v2.etcd_config.kind
      }
    }
    machine_pools {
      name                         = "worker-pool"
      cloud_credential_secret_name = rancher2_cloud_credential.vsphere.id
      control_plane_role           = false
      etcd_role                    = false
      worker_role                  = true
      quantity                     = var.cluster_worker_count
      machine_config {
        name = rancher2_machine_config_v2.worker_config.name
        kind = rancher2_machine_config_v2.worker_config.kind
      }
    }
  }
}
