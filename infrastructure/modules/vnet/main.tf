resource "azurerm_virtual_network" "vnet" {
  # Réseau virtuel (VNet) ----------------------------
  # Crée un réseau virtuel pour héberger les sous-réseaux.
  name = var.vnet_name
  location = var.physical_location
  resource_group_name = var.resource_group_name
  address_space = var.vnet_address_space # Plage d'adresses IP pour le réseau
}

resource "azurerm_subnet" "database_subnet" {
  # Sous-réseau pour la base de données --------------
  # Configure un sous-réseau dédié pour héberger les bases de données.
  name = var.database_subnet_name
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.database_subnet_address_prefixes
  service_endpoints = ["Microsoft.Storage"] # Point de terminaison pour accéder au stockage Azure

  delegation {
    # Délégation pour PostgreSQL flexible servers ----
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_subnet" "app_subnet" {
  # Sous-réseau pour l'application -------------------
  # Configure un sous-réseau pour héberger les services applicatifs.
  name = var.app_subnet_name
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.app_subnet_address_prefixes

  delegation {
    # Délégation pour les App Services ---------------
    name = "appServiceDelegation"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action",
      ]
    }
  }
}

resource "azurerm_subnet" "gateway_subnet" {
  # Sous-réseau pour la passerelle -------------------
  # Configure un sous-réseau dédié à la passerelle d'application.
  name = var.gateway_subnet_name
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.gateway_subnet_address_prefixes
}

resource "azurerm_network_security_group" "app_nsg" {
  # Groupe de sécurité pour le sous-réseau applicatif -
  # Définit les règles de sécurité pour contrôler le trafic entrant et sortant.
  name = "app-secu-group"
  resource_group_name = var.resource_group_name
  location = var.physical_location

  security_rule {
    # Règle pour autoriser le trafic depuis la DB -----
    name = "AllowDbSubnetTraffic"
    priority = 100 # Priorité de la règle
    direction = "Inbound" # Trafic entrant
    access = "Allow" # Autoriser
    protocol = "*" # Tous les protocoles
    source_port_range = "*" # Tous les ports source
    destination_port_range = "*" # Tous les ports de destination
    source_address_prefix = "10.0.1.0/24" # Sous-réseau de la base de données
    destination_address_prefix = "10.0.2.0/24" # Sous-réseau applicatif
  }
}

resource "azurerm_network_security_group" "db_nsg" {
  # Groupe de sécurité pour le sous-réseau DB ---------
  # Définit les règles de sécurité pour autoriser le trafic depuis le sous-réseau applicatif.
  name = "db-secu-group"
  resource_group_name = var.resource_group_name
  location = var.physical_location

  security_rule {
    # Règle pour autoriser le trafic depuis l'app -----
    name = "AllowAppSubnetTraffic"
    priority = 100 # Priorité de la règle
    direction = "Inbound" # Trafic entrant
    access = "Allow" # Autoriser
    protocol = "*" # Tous les protocoles
    source_port_range = "*" # Tous les ports source
    destination_port_range = "*" # Tous les ports de destination
    source_address_prefix = "10.0.2.0/24" # Sous-réseau applicatif
    destination_address_prefix = "10.0.1.0/24" # Sous-réseau de la base de données
  }
}