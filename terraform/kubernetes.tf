resource "flux_bootstrap_got" "this" {
  interval = "5m"
  path     = "kubernetes/clusters/testing"
}