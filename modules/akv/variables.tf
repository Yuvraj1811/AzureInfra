variable "keyvault_name" {
    type = string
  
}


variable "location" {
    type = string
  
}

variable "rg_name" {
    type = string
  
}

variable "secret_name" {
    type = string
  
}

variable "secrets" {
    type = map(string)
    default = {}
  
}