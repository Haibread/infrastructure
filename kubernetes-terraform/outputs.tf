#output "kubeconfig" {
#  value     = yamldecode(module.vsphere-k8s-rancher-cilium.kubeconfig).clusters.0.cluster.certificate-authority-data
#  sensitive = true
#}