resource "azurerm_network_interface" "nic" {

  for_each = toset(var.zones)

  name                = "nic-vm-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_association" {

  for_each = azurerm_network_interface.nic

  network_interface_id    = each.value.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = var.backend_pool_id
}

resource "azurerm_linux_virtual_machine" "vm" {

  for_each = toset(var.zones)

  name                = "vm-zone${each.key}"
  resource_group_name = var.resource_group
  location            = var.location
  size                = var.vm_size

  zone = each.key

  admin_username = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = var.ssh_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}