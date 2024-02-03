variable "vsphere_user" {
  type    = string
  default = ""
}

variable "vsphere_password" {
  type      = string
  sensitive = true
}