variable "vnet_name" {
  description = "Nom du réseau virtuel"
  type = string
}

variable "physical_location" {
  description = "Localisation du groupe de ressources et services"
  type = string
}

variable "app_subnet_name" {
  description = "Nom du sous-réseau de l'App"
  type = string
}

variable "app_subnet_address_prefixes" {
  description = "Préfixes de l'adresse de sous-réseau de l'App"
  type = list(string)
}

variable "resource_group_name" {
  description = "Nom du groupe de ressources"
  type = string
}

variable "gateway_subnet_name" {
  description = "Nom du gateway du sous-réseau"
  type = string
}

variable "gateway_subnet_address_prefixes" {
  description = "Préfixes de l'adresse du gateway de sous-réseau"
  type = list(string)
}

variable "vnet_address_space" {
  description = "Espace de l'adresse du réseau virtuel"
  type = list(string)
}

variable "database_subnet_name" {
  description = "Nom du sous-réseau"
  type = string
}

variable "database_subnet_address_prefixes" {
  description = "Préfixes de l'adresse du sous-réseau"
  type = list(string)
}
