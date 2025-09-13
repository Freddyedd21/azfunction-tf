# Definición del provider que ocuparemos


provider "azurerm" {
  features {}
  subscription_id = "d1e6f969-0e7e-456b-9324-8a0343e95482"

}

#Grupo de recursos
# Se crea el grupo de recursos, al cual se asociarán los demás recursos
resource "azurerm_resource_group" "rg" {
  name     = var.name_function
  location = var.location
}

# Red virtual

resource "azurerm_virtual_network" "vnet" {
  name = "${var.name_function}-vnet" # Nombre de la red virtual
  address_space = ["10.0.0.0/16"] # Espacio de direcciones IP
  location = azurerm_resource_group.rg.location # Ubicación
  resource_group_name = azurerm_resource_group.rg.name # Grupo de recursos

}

# Subred
resource "azurerm_subnet" "subnet" {
  name                 = "${var.name_function}-subnet" # Nombre de la subred
  resource_group_name  = azurerm_resource_group.rg.name # Grupo de recursos
  virtual_network_name = azurerm_virtual_network.vnet.name # Red virtual
  address_prefixes     = ["10.0.1.0/24"] # Espacio de direcciones IP de la subred
}

# Ip pública
resource "azurerm_public_ip" "public_ip" {
  name                = "${var.name_function}-public-ip" # Nombre de la IP pública
  location            = azurerm_resource_group.rg.location # Ubicación
  resource_group_name = azurerm_resource_group.rg.name # Grupo de recursos
  allocation_method   = "Static" # Método de asignación (Estática requerida para Standard SKU)

}

# interfaz de red
resource "azurerm_network_interface" "nic" {
  name                = "${var.name_function}-nic" # Nombre de la interfaz de red
  location            = azurerm_resource_group.rg.location # Ubicación
  resource_group_name = azurerm_resource_group.rg.name # Grupo de recursos

  ip_configuration {
    name                          = "internal" # Nombre de la configuración IP
    subnet_id                     = azurerm_subnet.subnet.id # ID de la subred
    private_ip_address_allocation = "Dynamic" # Asignación de IP privada (Estática o Dinámica)
    public_ip_address_id          = azurerm_public_ip.public_ip.id # ID de la IP pública
  }
}

# Seguridad de red
resource "azurerm_network_security_group" "nsg" {
  name = "${var.name_function}-nsg" # Nombre del grupo de seguridad de red
  location = azurerm_resource_group.rg.location # Ubicación
  resource_group_name = azurerm_resource_group.rg.name # Grupo de recursos

  security_rule{
    name = "SSH" # Nombre de la regla
    priority = 100 # Prioridad de la regla
    direction = "Inbound" # Dirección del tráfico (Inbound o Outbound)
    access = "Allow" # Permitir o Denegar
    protocol = "Tcp" # Protocolo (Tcp, Udp, o *)
    source_port_range = "*" # Rango de puertos de origen
    destination_port_range = "22" # Rango de puertos de destino
    source_address_prefix = "*" # Prefijo de dirección de origen
    destination_address_prefix = "*" # Prefijo de dirección de destino
  }
}

#asociar nsg a la nic
resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = azurerm_network_interface.nic.id # ID de la interfaz de red
  network_security_group_id = azurerm_network_security_group.nsg.id # ID del grupo de seguridad de red
}

#Maquina virtual de linux
resource "azurerm_linux_virtual_machine" "vm" {
  name = "${var.name_function}-vm" # Nombre de la máquina virtual
  resource_group_name = azurerm_resource_group.rg.name # Grupo de recursos
  location = azurerm_resource_group.rg.location # Ubicación
  disable_password_authentication = false # Permitir autenticación por contraseña
  size = "Standard_B1s" # Tamaño de la máquina virtual
  admin_username = "freddyedd21" # Nombre de usuario administrador
  network_interface_ids =  [
    azurerm_network_interface.nic.id, # ID de la interfaz de red
  ]

  admin_password = "Freddyedd12345+" # Contraseña de administrador (solo para pruebas, usa SSH en producción)

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "${var.name_function}-osdisk"
  }

    source_image_reference {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }
}





