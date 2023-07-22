output "kubeconfig" {
  value     = module.rancher2.kubeconfig
  sensitive = true
}