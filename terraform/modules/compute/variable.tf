variable "location" {}
variable "resource_group" {}
variable "subnet_id" {}
variable "ssh_key" {}
variable "backend_pool_id" {}

variable "zones" {
  type = list(string)
}

variable "vm_size" {
  type = string
}