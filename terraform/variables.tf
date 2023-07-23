variable "rancher_access_key" {
  type = string
}

variable "rancher_secret_key" {
  type = string
  sensitive = true
}

variable "vsphere_user" {
  type    = string
}

variable "vsphere_password" {
  type      = string
  sensitive = true
}