terraform {
  backend "s3" {
    bucket                      = "homelab-s3-terraforming"
    key                         = "terraform.tfstate"
    region                      = "gra"
    endpoints                   = { s3 = "https://s3.gra.perf.cloud.ovh.net" }
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true #https://github.com/hashicorp/terraform/issues/34053
  }
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.3.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">=1.0.1"
    }
    github = {
      source  = "integrations/github"
      version = ">=5.20.0"
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.6.1"
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
    url = "ssh://git@github.com/Haibread/infrastructure.git"
    ssh = {
      username    = "git"
      private_key = tls_private_key.flux.private_key_pem
    }
  }
}

provider "github" {
  owner = "Haibread"
  token = var.github_token
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = "vcenter.homelab.lan"
  allow_unverified_ssl = true
}

resource "tls_private_key" "flux" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "flux-key" {
  title      = "Flux"
  repository = "infrastructure"
  key        = tls_private_key.flux.public_key_openssh
  read_only  = "false"
}