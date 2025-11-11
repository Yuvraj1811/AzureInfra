variable "vnet_name" {
  type = string

}

variable "rg_name" {
  type = string

}

variable "location" {
  type = string

}

variable "address_space" {
  type = list(string)

}

variable "dns_servers" {
  type = list(string)

}


variable "subnets" {
  type = map(object({
    name             = string
    address_prefixes = list(string)

  }))

}
