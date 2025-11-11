resource "azurerm_mssql_server" "this" {
  name                         = var.sql_server_name
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = var.sql_version
  administrator_login          = var.admin_login
  administrator_login_password = var.sql_password
}

resource "azurerm_mssql_database" "this" {
  name         = var.db_name
  server_id    = azurerm_mssql_server.this.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = var.max_size_gb
  sku_name     = var.sku_name
  enclave_type = "VBS"


  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}

