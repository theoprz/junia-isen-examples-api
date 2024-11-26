resource "azurerm_public_ip" "my_public_ip" {
  # Adresse IP publique ------------------------------
  # Crée une ressource IP publique statique pour la passerelle.
  name = var.public_ip_name
  resource_group_name = var.resource_group_name
  location = var.physical_location
  allocation_method = "Static" # Type d'allocation : statique
}

locals {
  # Noms des composants de la passerelle -------------
  backend_address_pool_name = "${var.vnet_name}-backend-pool"       # Pool d'adresses backend
  frontend_port_name = "${var.vnet_name}-frontend-port"      # Port en frontend
  frontend_ip_configuration_name = "${var.vnet_name}-frontend-ip"        # Configuration IP en frontend
  http_settings_name = "${var.vnet_name}-http-settings"      # Paramètres HTTP pour le backend
  listener_name = "${var.vnet_name}-http-listener"      # Écouteur HTTP
  request_routing_rule_name = "${var.vnet_name}-routing-rule"       # Règle de routage des requêtes
  redirect_configuration_name = "${var.vnet_name}-redirect-config"    # Configuration de redirection
}

resource "azurerm_application_gateway" "gateway" {
  # Passerelle d'application -------------------------
  # Configure une passerelle d'application Azure (SKU : Standard_v2).
  name = var.application_gateway_name
  resource_group_name = var.resource_group_name
  location = var.physical_location

  sku {
    # Définition du SKU ------------------------------
    name = "Standard_v2" # Nom du SKU
    tier = "Standard_v2" # Niveau du SKU
    capacity = 2 # Nombre d'unités
  }

  gateway_ip_configuration {
    # Configuration IP de la passerelle --------------
    name = "my-gateway-ip-configuration"
    subnet_id = var.gateway_subnet_id
  }

  request_routing_rule {
    # Règle de routage des requêtes ------------------
    # Configure le routage des requêtes HTTP.
    backend_address_pool_name = local.backend_address_pool_name
    backend_http_settings_name = local.http_settings_name
    name = local.request_routing_rule_name
    priority = 9 # Priorité de la règle
    rule_type = "Basic" # Type de règle : Basique
    http_listener_name = local.listener_name
  }

  frontend_port {
    # Port d'écoute en frontend ----------------------
    name = local.frontend_port_name
    port = 80 # Port utilisé pour les requêtes HTTP
  }

  frontend_ip_configuration {
    # Configuration IP en frontend -------------------
    name = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.my_public_ip.id
  }

  backend_address_pool {
    # Pool d'adresses backend ------------------------
    name = local.backend_address_pool_name
    fqdns = [
      var.app_service_fqdn # Nom de domaine complet (FQDN: Full Qualified Domain Name) du service backend
    ]
  }

  backend_http_settings {
    # Paramètres HTTP pour le backend ----------------
    name = local.http_settings_name
    cookie_based_affinity = "Disabled" # Affinité basée sur les cookies désactivée
    port = 80 # Port utilisé
    path = "/" # Chemin par défaut
    protocol = "Http" # Protocole HTTP
    request_timeout = 5 # Timeout des requêtes (en secondes)
  }

  http_listener {
    # Listener HTTP ----------------------------------
    name = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name = local.frontend_port_name
    protocol  = "Http"
  }
}