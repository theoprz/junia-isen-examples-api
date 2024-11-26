resource "random_string" "rdm_name_server" {
  # Génération d'un nom aléatoire pour le serveur ----
  # Crée une chaîne aléatoire de 32 caractères pour garantir un nom unique pour le serveur PostgreSQL.
  length = 32 # Longueur de la chaîne
  special = false # Pas de caractères spéciaux
  upper = false # Pas de majuscules
}

resource "azurerm_private_dns_zone" "my_dns_zone" {
  # Zone DNS privée ----------------------------------
  # Définit une zone DNS privée pour le serveur PostgreSQL.
  name = var.my_dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "my_dns_zone_link" {
  # Lien entre la zone DNS et le réseau virtuel ------
  # Associe la zone DNS privée au réseau virtuel.
  name = var.my_dns_zone_link_name
  resource_group_name = var.resource_group_name
  virtual_network_id = var.vnet_id
  private_dns_zone_name = azurerm_private_dns_zone.my_dns_zone.name
}

resource "azurerm_postgresql_flexible_server" "my_postgresql_server" {
  # Serveur PostgreSQL flexible ----------------------
  # Crée un serveur PostgreSQL dans une zone DNS privée.
  name = "postgresqlflexibleserver${random_string.rdm_name_server.result}" # Nom unique avec chaîne aléatoire
  resource_group_name = var.resource_group_name
  location = var.physical_location

  delegated_subnet_id = var.database_subnet_id # Sous-réseau délégué pour la base de données
  private_dns_zone_id = azurerm_private_dns_zone.my_dns_zone.id # Lien avec la zone DNS privée
  public_network_access_enabled = false # Désactive l'accès public pour des raisons de sécurité
  administrator_login = var.administrator_login
  administrator_password = var.administrator_password

  version = "16" # Version de PostgreSQL
  zone = "1" # Zone de disponibilité
  storage_mb = 32768 # Taille de stockage en Mo (32 Go)
  storage_tier = "P4" # Tier de stockage

  sku_name = "B_Standard_B1ms" # SKU : Instance Basic avec 1 vCPU et mémoire partagée pour des raisons de coûts
  depends_on = [azurerm_private_dns_zone_virtual_network_link.my_dns_zone_link] # Dépendance au lien DNS
}

resource "azurerm_postgresql_flexible_server_database" "my_db" {
  # Base de données sur le serveur PostgreSQL --------
  # Crée une base de données sur le serveur PostgreSQL flexible.
  name = var.postgresql_db_name
  server_id = azurerm_postgresql_flexible_server.my_postgresql_server.id
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_webapp" {
  # Règle de pare-feu pour autoriser l'application ---
  # Définit une règle de pare-feu pour autoriser l'accès depuis le sous-réseau de l'application.
  start_ip_address = "10.0.2.0" # Adresse IP de début (plage du sous-réseau)
  end_ip_address = "10.0.2.255" # Adresse IP de fin (plage du sous-réseau)
  name = "AllowWebApp" # Nom de la règle
  server_id = azurerm_postgresql_flexible_server.my_postgresql_server.id
}