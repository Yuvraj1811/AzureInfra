resource "azurerm_log_analytics_workspace" "this" {
  name                = var.workspace_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"        # You can also use "Free" for testing
  retention_in_days   = var.retention_in_days


}
