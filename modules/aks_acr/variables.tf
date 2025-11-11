variable "aks_name" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "node_count" {
  type    = number
  default = 2
}

variable "node_vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "acr_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}
