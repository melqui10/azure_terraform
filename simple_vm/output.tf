output "rg_name" {
  value     = azurerm_resource_group.rg.name
  sensitive = false
}

output "public_ip" {
  value     = azurerm_public_ip.pip.ip_address
  sensitive = false
}

