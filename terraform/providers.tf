terraform {
  backend "s3" {
    bucket                      = "homelab-s3-terraforming"
    key                         = "terraform.tfstate"
    region                      = "gra"
    endpoint                    = "s3.gra.perf.cloud.ovh.net"
    skip_credentials_validation = true
    skip_region_validation      = true
  }
}