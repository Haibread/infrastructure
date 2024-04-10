resource "helm_release" "argocd-root-app" {
  name             = "argocd-root-app"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argocd-apps"
  namespace        = "argocd"
  create_namespace = true
  version          = "1.6.2"
  values           = [file("${path.module}/argocd-root-app.yaml")]
}