# Criação do resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.workload}-dev-${var.region}-001"
  location = var.location

  tags = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.workload}-dev-${var.region}-001"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = var.vnet_address_space

  tags = var.tags
}

resource "azurerm_subnet" "snet" {
  name                 = "snet-${var.workload}-dev-${var.region}-001"
  address_prefixes     = var.snet_address_space
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_public_ip" "pip" {
  name                = "pip-${var.vm.name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}
resource "azurerm_network_interface" "nic_linux" {
  name                = "nic-${var.vm.name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.snet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm_linux" {
  name                = var.vm.name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm.size
  admin_username      = var.vm.user
  network_interface_ids = [
    azurerm_network_interface.nic_linux.id,
  ]
  disable_password_authentication = false
  admin_password                  = var.vm.password
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  custom_data = base64encode(file("cloud-init-script.sh"))
  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}