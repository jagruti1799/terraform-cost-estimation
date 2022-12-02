resource "azurerm_network_security_group" "nginxnsg" {
  name                = "nginx-nsg"
  location            = var.location
  resource_group_name = "sa1_dev_eic_dovercorp_devops_poc"

  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "42.106.205.56"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowHTTP"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "42.106.205.56"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  
    tags = {
    Resource_Owner= "Alpesh Bhavsar"
    Delivery_Manager = "Yash Badiani"
    Business_Unit = "PES"
    Project_name = "DoverPoC"
    Create_Date = "01/12/22"
  }
}

resource "azurerm_network_interface_security_group_association" "ngnixassosiation" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nginxnsg.id
}