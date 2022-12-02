resource "azurerm_virtual_network" "vnet" {
  name                = "myvnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = "sa1_dev_eic_dovercorp_devops_poc"
    tags = {
    Resource_Owner= "Alpesh Bhavsar"
    Delivery_Manager = "Yash Badiani"
    Business_Unit = "PES"
    Project_name = "DoverPoC"
    Create_Date = "01/12/22"
  }
}

resource "azurerm_public_ip" "publicip" {
  name                = "publicip"
  location            = var.location
  resource_group_name = "sa1_dev_eic_dovercorp_devops_poc"
  allocation_method   = "Static"

}

resource "azurerm_subnet" "subnet" {
  name                 = "Websubnet"
  resource_group_name = "sa1_dev_eic_dovercorp_devops_poc"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "mynic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "publicip"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }
    tags = {
    Resource_Owner= "Alpesh Bhavsar"
    Delivery_Manager = "Yash Badiani"
    Business_Unit = "PES"
    Project_name = "DoverPoC"
    Create_Date = "01/12/22"
  }
}