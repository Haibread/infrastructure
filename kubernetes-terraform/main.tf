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

  cluster_controlplane_cpu          = var.cluster_controlplane_cpu
  cluster_controlplane_memory       = var.cluster_controlplane_memory
  cluster_controlplane_disk         = var.cluster_controlplane_disk
  cluster_controlplane_count        = var.cluster_controlplane_count
  cluster_controlplane_network_name = "TKG Management Network - 111"

  cluster_etcd_cpu          = var.cluster_etcd_cpu
  cluster_etcd_memory       = var.cluster_etcd_memory
  cluster_etcd_disk         = var.cluster_etcd_disk
  cluster_etcd_count        = var.cluster_etcd_count
  cluster_etcd_network_name = "TKG Management Network - 111"

  cluster_worker_cpu          = var.cluster_worker_cpu
  cluster_worker_memory       = var.cluster_worker_memory
  cluster_worker_disk         = var.cluster_worker_disk
  cluster_worker_count        = var.cluster_worker_count
  cluster_worker_network_name = "TKG Workload network - 112"
}
