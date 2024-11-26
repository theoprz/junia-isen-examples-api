resource "azurerm_service_plan" "api_plan" {
  # Plan de service pour l'application ---------------
  # Crée un plan de service Azure pour héberger l'application web.
  name = var.service_plan_name
  resource_group_name = var.resource_group_name
  location = var.physical_location
  os_type = "Linux"
  sku_name = "B1" # Niveau de service : Basique (B1) car moins cher
}

resource "azurerm_role_assignment" "app_service_storage_access" {
  # Attribution de rôle pour l'accès au stockage -----
  # Donne à l'App Service les droits nécessaires pour accéder au Blob Storage.
  role_definition_name = "Storage Blob Data Contributor"
  principal_id = azurerm_linux_web_app.app_service.identity[0].principal_id
  scope = var.storage_account_id
}

resource "azurerm_linux_web_app" "app_service" {
  # Définition de l'App Service ----------------------
  # Configure une application web sous Linux utilisant Docker.
  name = var.app_service_name
  resource_group_name = var.resource_group_name
  location = var.physical_location
  public_network_access_enabled = true # Permet l'accès public
  virtual_network_subnet_id = var.app_subnet_id
  service_plan_id = azurerm_service_plan.api_plan.id

  site_config {
    application_stack {
      # Configuration de l'image Docker --------------
      docker_registry_url = var.docker_registry_url
      docker_image_name = var.docker_image
      docker_registry_password = var.docker_registry_password
      docker_registry_username = var.docker_registry_username
    }
  }

  app_settings = {
    # Variables pour la base de données --------------
    DATABASE_HOST = var.database_host
    DATABASE_PORT = var.database_port
    DATABASE_NAME = var.database_name
    DATABASE_USER = var.database_user
    DATABASE_PASSWORD = var.database_password

    # URL pour le stockage ---------------------------
    STORAGE_ACCOUNT_URL = var.storage_url

    # Clé de licence pour New Relic ------------------
    "NEW_RELIC_LICENSE_KEY" = var.new_relic_license_key
  }

  identity {
    # Identité managée attribuée par le système ------
    type = "SystemAssigned"
  }
}