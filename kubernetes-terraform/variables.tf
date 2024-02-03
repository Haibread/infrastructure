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
