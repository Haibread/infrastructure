resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = false
  version          = "6.6.0"
  values           = [file("${path.module}/argocd.yaml")]

  depends_on = [kubernetes_namespace.argocd]
}

resource "kubernetes_secret" "github-repo" {
  metadata {
    name      = "github-private-repo"
    namespace = "argocd"
    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  data = {
    type     = "git"
    url      = "https://github.com/Haibread/infrastructure"
    username = "not-used"
    password = var.git_access_token
  }
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}