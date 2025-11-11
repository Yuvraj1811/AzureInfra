output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.this.name
}

output "aks_kube_config" {
  value     = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive = true
}

output "acr_login_server" {
  value = azurerm_container_registry.this.login_server
}

output "acr_admin_username" {
  value = azurerm_container_registry.this.admin_username
}

output "acr_admin_password" {
  value     = azurerm_container_registry.this.admin_password
  sensitive = true
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.this.name
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.this.id
}



