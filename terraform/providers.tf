terraform {
  backend "s3" {
    bucket                      = "homelab-s3-terraforming"
    key                         = "terraform.tfstate"
    region                      = "gra"
    endpoint                    = "s3.gra.perf.cloud.ovh.net"
    skip_credentials_validation = true
    skip_region_validation      = true
  }
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.3.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = "1.0.1"
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = module.vsphere-k8s-rancher-cilium.cluster-endpoint
    cluster_ca_certificate = base64decode(module.vsphere-k8s-rancher-cilium.certificate-authority-data)
    token                  = module.vsphere-k8s-rancher-cilium.kubeconfig-token
  }
}

provider "flux" {
  kubernetes = {
    host                   = module.vsphere-k8s-rancher-cilium.cluster-endpoint
    cluster_ca_certificate = base64decode(module.vsphere-k8s-rancher-cilium.certificate-authority-data)
    token                  = module.vsphere-k8s-rancher-cilium.kubeconfig-token
  }
  git = {
    url = "https://github.com/Haibread/infrastructure.git"
    http = {
      allow_insecure_http = false
    }
  }
}