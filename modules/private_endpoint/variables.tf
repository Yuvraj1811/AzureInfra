variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "private_service_connection" {
  description = "Map of private connections and their details"
  type = map(object({
    resource_id        = string
    subresource_names  = list(string)
  }))
}


