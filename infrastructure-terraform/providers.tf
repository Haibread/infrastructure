terraform {
  backend "s3" {
    bucket                      = "homelab-s3-terraforming"
    key                         = "infrastructure.tfstate"
    region                      = "gra"
    endpoints                   = { s3 = "https://s3.gra.perf.cloud.ovh.net" }
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true #https://github.com/hashicorp/terraform/issues/34053
  }
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.6.1"
    }
  }
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = "vcenter.homelab.lan"
  allow_unverified_ssl = true
}