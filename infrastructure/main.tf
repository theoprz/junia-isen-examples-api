provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

module "resource_group" {
  # Emplacement du module Groupe de Ressources -------
  source = "./modules/resource_group"

  # Variables principales de l'app -------------------
  resource_group_name = var.resource_group_name
  physical_location = var.physical_location
}

module "app_service" {
  # Emplacement du module App Service ----------------
  source = "./modules/app_service"

  # Variables principales de l'app -------------------
  app_service_name = var.app_service_name
  resource_group_name = module.resource_group.resource_group_name
  physical_location = module.resource_group.physical_location
  service_plan_name = var.service_plan_name
  app_subnet_id = module.vnet.app_subnet_id

  # Variables concernant le registre Docker ----------
  docker_image = var.docker_image
  docker_registry_username = var.docker_registry_username
  docker_registry_password = var.docker_registry_password
  docker_registry_url = var.docker_registry_url

  # Variables concernant la BDD ----------------------
  database_host = module.database.postgresql_host
  database_port = module.database.postgresql_port
  database_name = module.database.postgresql_db_name
  database_user = var.administrator_login
  database_password = var.administrator_password

  # Variables concernant le blob storage -------------
  storage_url = module.blob_storage.storage_url
  storage_account_id = module.blob_storage.storage_account_id

  # Variables concernant le Monitoring ---------------
  new_relic_license_key = var.new_relic_license_key
}

module "vnet" {
  # Emplacement du module VNet -----------------------
  source = "./modules/vnet"

  # Variables principales de l'app -------------------
  resource_group_name = module.resource_group.resource_group_name
  physical_location = module.resource_group.physical_location

  # Variables concernant le réseau virtuel -----------
  vnet_name = var.vnet_name
  vnet_address_space = var.vnet_address_space

  # Variables concernant la BDD ----------------------
  database_subnet_name = var.database_subnet_name
  database_subnet_address_prefixes = var.database_subnet_address_prefixes

  # Variables concernant le sous-réseau --------------
  app_subnet_name = var.app_subnet_name
  app_subnet_address_prefixes = var.app_subnet_address_prefixes

  # Variables concernant le gateway ------------------
  gateway_subnet_name = var.gateway_subnet_name
  gateway_subnet_address_prefixes = var.gateway_subnet_address_prefixes
}

module "database" {
  # Emplacement du module Database -------------------
  source = "./modules/database"

  # Variables principales de l'app -------------------
  resource_group_name = module.resource_group.resource_group_name
  physical_location = module.resource_group.physical_location

  # Variables concernant le réseau virtuel -----------
  vnet_id = module.vnet.vnet_id

  # Variables concernant la BDD ----------------------
  postgresql_db_name = var.postgresql_db_name
  database_subnet_id = module.vnet.database_subnet_id
  administrator_login = var.administrator_login
  administrator_password = var.administrator_password

  # Variables concernant la zone DNS -----------------
  my_dns_zone_name = var.my_dns_zone_name
  my_dns_zone_link_name = var.my_dns_zone_link_name
}

module "blob_storage" {
  # Emplacement du module Blob Storage ---------------
  source = "./modules/blob_storage"

  # Variables principales de l'app -------------------
  resource_group_name = module.resource_group.resource_group_name
  physical_location = module.resource_group.physical_location
}

module "api_gateway" {
  # Emplacement du module App Gateway ----------------
  source = "./modules/application_gateway"

  # Variables principales de l'app -------------------
  application_gateway_name = var.application_gateway_name
  resource_group_name = module.resource_group.resource_group_name
  physical_location = module.resource_group.physical_location

  # Variables concernant le réseau -------------------
  public_ip_name = var.public_ip_name
  vnet_name = module.vnet.vnet_name
  gateway_subnet_id = module.vnet.gateway_subnet_id
  gateway_subnet_name = module.vnet.gateway_subnet_name
  app_service_fqdn = module.app_service.app_service_fqdn
}
