output "kubeconfig" {
  value     = rancher2_cluster_v2.tfcluster.kube_config
  sensitive = true
}