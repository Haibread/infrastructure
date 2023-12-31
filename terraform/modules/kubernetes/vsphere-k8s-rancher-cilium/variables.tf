# Authentication
variable "rancher_url" {
  type = string
}

variable "rancher_access_key" {
  type = string
}

variable "rancher_secret_key" {
  type      = string
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

variable "cluster_kubernetes_version" {
  type = string
}

# VMware vars
variable "cluster_vmware_datacenter" {
  type    = string
  default = ""
}

variable "cluster_vmware_datastore" {
  type    = string
  default = "vsanDatastore"
}

variable "cluster_vmware_resource_pool" {
  type    = string
  default = ""
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

# Network vars
variable "cluster_network_cidr" {
  type    = string
  default = ""
}

variable "cluster_worker_network_name" {
  type = string
  //default = ""
}

variable "cluster_etcd_network_name" {
  type = string
  //default = ""
}

variable "cluster_controlplane_network_name" {
  type = string
  //default = ""
}