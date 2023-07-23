output "kubeconfig" {
  value     = rancher2_cluster_v2.tfcluster.kube_config
  sensitive = true
}

output "certificate-authority-data" {
  value     = yamldecode(rancher2_cluster_v2.tfcluster.kube_config).clusters.0.cluster.certificate-authority-data
  sensitive = true
}

output "kubeconfig-token" {
  value     = yamldecode(rancher2_cluster_v2.tfcluster.kube_config).users.0.user.token
  sensitive = true
}

output "cluster-endpoint" {
  value     = yamldecode(rancher2_cluster_v2.tfcluster.kube_config).clusters.0.cluster.server
  sensitive = true
}