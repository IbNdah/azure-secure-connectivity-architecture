resource "azurerm_public_ip" "bastion_pip" {
  name                = "pip-bastion"
  location            = var.location
  resource_group_name = var.resource_group

  allocation_method = "Static"
  sku               = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = "bastion-host"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                 = "bastion-config"
    subnet_id            = var.bastion_subnet
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
}