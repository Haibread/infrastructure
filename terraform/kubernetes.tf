resource "flux_bootstrap_git" "this" {
  interval = "5m"
  path     = "kubernetes/clusters/testing"
}