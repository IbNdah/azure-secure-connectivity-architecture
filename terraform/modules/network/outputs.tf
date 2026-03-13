output "app_subnet_id" {
  value = azurerm_subnet.app.id
}

output "bastion_subnet_id" {
  value = azurerm_subnet.bastion.id
}