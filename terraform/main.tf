module "k8s-rancher-cilium" {
  source = "./kubernetes/k8s-rancher-cilium"

  rancher_url  = "https://192.168.0.5:6587"
  vsphere_vcenter_address = "vcenter.homelab.lan"
  
  # Declared by GitLab CI/CD secrets
  #rancher_access_key = ""
  #rancher_secret_key = ""
  #vsphere_user
  #vsphere_password   = ""
}
