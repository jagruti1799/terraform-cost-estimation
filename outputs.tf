output "public_ip_address" {
  value       = azurerm_public_ip.publicip.*.ip_address
}

output "vm_name" {
  value = azurerm_virtual_machine.vm.*.name
}