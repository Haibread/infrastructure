terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = ">= 2.28.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.11.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "scaleway" {
  region = "fr-par"
}

provider "kubernetes" {
  host                   = var.cluster_host
  token                  = var.cluster_token
  cluster_ca_certificate = base64decode(var.cluster_certificate)
}
provider "kubectl" {
  host                   = var.cluster_host
  token                  = var.cluster_token
  cluster_ca_certificate = base64decode(var.cluster_certificate)
  load_config_file       = false
}
provider "helm" {
  kubernetes {
    host                   = var.cluster_host
    token                  = var.cluster_token
    cluster_ca_certificate = base64decode(var.cluster_certificate)
  }
}