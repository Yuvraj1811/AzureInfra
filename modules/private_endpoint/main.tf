
resource "azurerm_private_endpoint" "this" {
  for_each            = var.private_service_connection
  name                = "${var.name}-${each.key}-pe"
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${each.key}-connection"
    private_connection_resource_id = each.value.resource_id
    subresource_names              = each.value.subresource_names
    is_manual_connection           = false
  }
}
