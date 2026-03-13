provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  location = var.location
}

module "network" {
  source = "../../modules/network"

  vnet_name      = "vnet-secure"
  location       = var.location
  resource_group = azurerm_resource_group.rg.name
}

module "loadbalancer" {
  source = "../../modules/loadbalancer"

  location       = var.location
  resource_group = azurerm_resource_group.rg.name
}

module "compute" {
  source = "../../modules/compute"

  location       = var.location
  resource_group = azurerm_resource_group.rg.name
  subnet_id      = module.network.app_subnet_id

  backend_pool_id = module.loadbalancer.backend_pool_id

  zones = ["1","2"]

  vm_size = "Standard_B2s"

  ssh_key = file(var.ssh_public_key)
}