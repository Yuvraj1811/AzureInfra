variable "sql_server_name" {
    type = string
  
}

variable "rg_name" {
    type = string
  
}

variable "location" {
    type = string
  
}

variable "sql_version" {
    type = string
    default = "12.0"
  
}

variable "admin_login" {
    type = string
  
}

variable "sql_password" {
    type = string
    sensitive = true
  
}

variable "db_name" {
    type = string
  
}

variable "max_size_gb" {
    type = number
    default = 2
  
}

variable "sku_name" {
    type = string
    default = "S0"
  
}