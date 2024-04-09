// Declared in Actions workflow
variable "rancher_access_key" {
  type = string
}

variable "rancher_secret_key" {
  type      = string
  sensitive = true
}

variable "vsphere_user" {
  type    = string
  default = ""
}

variable "vsphere_password" {
  type      = string
  sensitive = true
}

variable "github_token" {
  sensitive = true
  type      = string
}

//variable "github_org" {
//  type = string
//}

//variable "github_repository" {
//  type = string
//}

// Vars
variable "environment" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "kubernetes_image_name" {
  type = string
}


# Worker node vars
variable "cluster_worker_count" {
  type    = number
  default = 1
}

variable "cluster_worker_cpu" {
  type    = number
  default = 2
}

variable "cluster_worker_memory" {
  type    = number
  default = 4096
}

variable "cluster_worker_disk" {
  type    = number
  default = 20
}

# ETCD node vars
variable "cluster_etcd_count" {
  type    = number
  default = 3
}

variable "cluster_etcd_cpu" {
  type    = number
  default = 2
}

variable "cluster_etcd_memory" {
  type    = number
  default = 4096
}
variable "cluster_etcd_disk" {
  type    = number
  default = 20
}

# Controlplane node vars
variable "cluster_controlplane_count" {
  type    = number
  default = 3
}

variable "cluster_controlplane_cpu" {
  type    = number
  default = 2
}

variable "cluster_controlplane_memory" {
  type    = number
  default = 4096
}

variable "cluster_controlplane_disk" {
  type    = number
  default = 20
}