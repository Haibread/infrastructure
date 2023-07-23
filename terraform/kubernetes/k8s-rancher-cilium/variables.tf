# Authentication
variable "rancher_url" {
  type    = string
  default = ""
}

variable "rancher_access_key" {
  type    = string
  default = ""
}

variable "rancher_secret_key" {
  type      = string
  default   = ""
  sensitive = true
}

variable "vsphere_vcenter_address" {
  type    = string
  default = ""
}

variable "vsphere_vcenter_port" {
  type    = string
  default = "443"
}

variable "vsphere_user" {
  type    = string
  default = ""
}

variable "vsphere_password" {
  type      = string
  default   = ""
  sensitive = true
}

# Cluster vars
variable "cluster_name" {
  type    = string
  default = "k8s-rancher-cilium"
}

# Worker node vars
variable "cluster_worker_count" {
  type    = number
  default = 3
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

variable "cluster_image_name" {
  type = string
}