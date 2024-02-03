resource "flux_bootstrap_git" "this" {
  interval   = "5m"
  path       = "kubernetes/clusters/${var.environment}"
  depends_on = [github_repository_deploy_key.flux-key]

}