module "vsphere-k8s-rancher-cilium" {
  source = "./modules/kubernetes/vsphere-k8s-rancher-cilium"

  rancher_url             = "https://rancher.newgamer.lan"
  vsphere_vcenter_address = "vcenter.homelab.lan"
  rancher_access_key      = var.rancher_access_key
  rancher_secret_key      = var.rancher_secret_key
  vsphere_user            = var.vsphere_user
  vsphere_password        = var.vsphere_password

  cluster_vmware_datacenter    = "Homelab"
  cluster_vmware_resource_pool = "FX2S/Resources"

  cluster_name               = "${var.environment}-k8s-rancher-cilium-cluster"
  cluster_kubernetes_version = var.kubernetes_version
  cluster_image_name         = var.kubernetes_image_name

  cluster_controlplane_cpu          = 8
  cluster_controlplane_memory       = 4096
  cluster_controlplane_disk         = 20
  cluster_controlplane_count        = 1
  cluster_controlplane_network_name = "TKG Management Network - 111"

  cluster_etcd_cpu          = 8
  cluster_etcd_memory       = 4096
  cluster_etcd_disk         = 20
  cluster_etcd_count        = 1
  cluster_etcd_network_name = "TKG Management Network - 111"

  cluster_worker_cpu          = 8
  cluster_worker_memory       = 4096
  cluster_worker_disk         = 20
  cluster_worker_count        = 1
  cluster_worker_network_name = "TKG Workload network - 112"
}
