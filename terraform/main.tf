module "k8s-rancher-cilium" {
  source = "./kubernetes/k8s-rancher-cilium"

  rancher_url             = "https://192.168.0.5:6587"
  vsphere_vcenter_address = "vcenter.homelab.lan"

  cluster_name                      = "test-cluster"
  cluster_kubernetes_version        = "v1.26.6+rke2r1"
  cluster_image_name                = "jammy-server-cloudimg-prepared-3"
  cluster_controlplane_network_name = "TKG Management Network - 111"
}
