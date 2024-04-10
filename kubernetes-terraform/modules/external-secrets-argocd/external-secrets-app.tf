resource "helm_release" "external-secrets" {
  name             = "external-secrets"
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  namespace        = "external-secrets"
  create_namespace = false
  version          = "0.9.13"
  values           = [file("${path.module}/external-secrets-values.yaml")]

  depends_on = [kubernetes_namespace.external-secrets]
}

resource "kubernetes_secret" "scw-secrets-store-secret-key" {
  metadata {
    name      = "scw-secrets-store-secret-key"
    namespace = "external-secrets"
  }
  data = {
    secretKey = var.scw_secret_key
  }
  depends_on = [helm_release.external-secrets]
}

resource "kubernetes_namespace" "external-secrets" {
  metadata {
    name = "external-secrets"
  }
}