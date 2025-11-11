resource "azurerm_linux_virtual_machine" "this" {
  name                            = var.vm_name
  resource_group_name             = var.rg_name
  location                        = var.location
  size                            = var.size
  admin_username                  = var.admin_username
  admin_password                  = data.azurerm_key_vault_secret.vm_admin_password.value
  network_interface_ids           = [var.nic_id]
  disable_password_authentication = false



  os_disk {
    name                 = "${var.vm_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}

data "azurerm_key_vault_secret" "vm_admin_password" {
  name         = "admin-password-new02"
  key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_key_vault" "this" {
  name                = var.keyvault_name
  resource_group_name = var.rg_name
}
