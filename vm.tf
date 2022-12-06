resource "tls_private_key" "nginxkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "nginxkey" {
  filename= "nginxkey.pem"  
  content= tls_private_key.nginxkey.private_key_pem 
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "nginx-vm"
  location              = var.location
  resource_group_name = "sa1_dev_eic_dovercorp_devops_poc"
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_B2s"

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "Linux"
    admin_username = "adminuser"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
     path     = "/home/adminuser/.ssh/authorized_keys"
     key_data = tls_private_key.nginxkey.public_key_openssh
    }
}
      connection {
      type = "ssh"
      user = "adminuser"
      host = azurerm_public_ip.publicip.ip_address
      private_key = tls_private_key.nginxkey.private_key_pem
       } 

   provisioner "local-exec" {
    command = "chmod 600 nginxkey.pem"
  }
  tags = {
    "Resource Owner" = "Alpesh Bhavsar"
    "Delivery Manager" = "Yash Badiani"
    "Business Unit" = "PES"
    "Project name" = "DoverPoC"
    "Create Date" = "01/12/22"
  }

  depends_on = [
    azurerm_network_interface_security_group_association.ngnixassosiation
  ]
}

resource "azurerm_public_ip" "lbpublicip" {
  name                = "lbpublicip"
  location            = var.location
  resource_group_name = "sa1_dev_eic_dovercorp_devops_poc"
  allocation_method   = "Static"
  
  tags = {
    "Resource Owner" = "Alpesh Bhavsar"
    "Delivery Manager" = "Yash Badiani"
    "Business Unit" = "PES"
    "Project name" = "DoverPoC"
    "Create Date" = "01/12/22"
  }
}

resource "azurerm_lb" "nginx_lb" {
  name                = "ngnix_lb"
  location            = var.location
  resource_group_name = "sa1_dev_eic_dovercorp_devops_poc"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lbpublicip.id
    }
  tags = {
    "Resource Owner" = "Alpesh Bhavsar"
    "Delivery Manager" = "Yash Badiani"
    "Business Unit" = "PES"
    "Project name" = "DoverPoC"
    "Create Date" = "01/12/22"
  }
}
