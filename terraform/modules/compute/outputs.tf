output "vm_ids" {
  value = {
    for k, vm in azurerm_linux_virtual_machine.vm :
    k => vm.id
  }
}