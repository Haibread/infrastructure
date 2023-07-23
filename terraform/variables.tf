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