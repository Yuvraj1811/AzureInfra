module "resource_group" {
  source   = "../../modules/resource_group"
  rg_name  = var.rg_name
  location = var.location

}

module "log_analytics" {
  source         = "../../modules/log_analytics"
  workspace_name = "dev-law"
  rg_name        = var.rg_name
  location       = var.location
  retention_in_days = 30


  depends_on = [module.resource_group]
}

module "virtual_network" {
  source        = "../../modules/network"
  vnet_name     = var.vnet_name
  location      = var.location
  rg_name       = var.rg_name
  address_space = var.address_space
  dns_servers   = var.dns_servers
  subnets       = var.subnets

  depends_on = [module.resource_group]
}

module "nsg" {
  source         = "../../modules/nsg"
  nsg_name       = var.nsg_name
  rg_name        = var.rg_name
  location       = var.location
  security_rules = var.security_rule


  depends_on = [module.virtual_network]
}

module "nic" {
  source    = "../../modules/nic"
  nic_name  = var.nic_name
  rg_name   = var.rg_name
  location  = var.location
  subnet_id = module.virtual_network.subnet_ids["frontend"]

  depends_on = [module.virtual_network]
}

module "vitual_machine" {
  source         = "../../modules/vm_bastion"
  vm_name        = "vmwebserver"
  location       = var.location
  rg_name        = var.rg_name
  nic_id         = module.nic.nic_id
  admin_username = var.admin_username
  keyvault_name  = module.keyvault.keyvault_name
  depends_on     = [module.nic]

}


module "keyvault" {
  source        = "../../modules/akv"
  keyvault_name = "kv01-tf"
  location      = var.location
  rg_name       = var.rg_name
  secret_name   = "admin-password-new02"
  secrets       = var.secrets

  depends_on = [module.resource_group]


}



module "database" {
  source          = "../../modules/database"
  sql_server_name = var.sql_server_name
  rg_name         = var.rg_name
  location        = var.location
  admin_login     = var.admin_login
  sql_password    = var.secrets["sql-admin-pass-new02"]
  db_name         = var.db_name

  depends_on = [ module.keyvault ]

}


module "private_endpoints" {
  source      = "../../modules/private_endpoint"
  name        = "dev"
  location    = var.location
  rg_name     = var.rg_name
  subnet_id   = module.virtual_network.subnet_ids["backend"]

  private_service_connection = {
    sqlserver = {
      resource_id       = module.database.sql_server_id
      subresource_names = ["sqlServer"]
    }
    keyvault = {
      resource_id       = module.keyvault.keyvault_id
      subresource_names = ["vault"]
    }
  }

  depends_on = [module.database, module.keyvault, module.virtual_network]
}


module "appgateway" {
  source      = "../../modules/appgateway_lb"
  name        = "dev-appgw"
  location    = var.location
  rg_name     = var.rg_name
  subnet_id   = module.virtual_network.subnet_ids["frontend"]
  backend_pool = [
    module.vitual_machine.vm_private_ip
  ]

  depends_on = [module.vitual_machine, module.virtual_network]
}


resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}

module "aks_acr" {
  source      = "../../modules/aks_acr"
  aks_name    = "dev-aks"
  rg_name     = var.rg_name
  location    = var.location
  node_count  = 2
  node_vm_size = "Standard_B2s"
  acr_name    = "devacr01${random_string.suffix.result}"
  dns_prefix  = "dev-aks"

  depends_on = [module.resource_group, module.virtual_network]
}















