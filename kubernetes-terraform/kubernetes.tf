module "argocd-install" {
  source           = "./modules/argocd-install"
  git_access_token = var.github_token

  cluster_host           = module.vsphere-k8s-rancher-cilium.cluster-endpoint
  cluster_token          = module.vsphere-k8s-rancher-cilium.kubeconfig-token
  cluster_ca_certificate = module.vsphere-k8s-rancher-cilium.certificate-authority-data
}

module "argocd-config" {
  source                 = "./modules/argocd-config"
  cluster_host           = module.vsphere-k8s-rancher-cilium.cluster-endpoint
  cluster_token          = module.vsphere-k8s-rancher-cilium.kubeconfig-token
  cluster_ca_certificate = module.vsphere-k8s-rancher-cilium.certificate-authority-data

}

module "external-secrets" {
  source              = "./modules/external-secrets-argocd"
  cluster_host        = module.vsphere-k8s-rancher-cilium.cluster-endpoint
  cluster_token       = module.vsphere-k8s-rancher-cilium.kubeconfig-token
  cluster_certificate = module.vsphere-k8s-rancher-cilium.certificate-authority-data
  scw_secret_key      = var.scw_secret_key
}