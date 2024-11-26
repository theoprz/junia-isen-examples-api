variable "public_ip_name" {
  description = "Nom de l'IP publique"
  type = string
}

variable "resource_group_name" {
  description = "Nom du groupe de ressources"
  type = string
}

variable "physical_location" {
  description = "Localisation du groupe de ressources et des autres services"
  type = string
}

variable "vnet_name" {
  description = "Nom du réseau virtuel"
  type = string
}

variable "gateway_subnet_name" {
  description = "Nom du sous-réseau"
  type = string
}

variable "gateway_subnet_id" {
  description = "ID du sous-réseau"
  type = string
}

variable "application_gateway_name" {
  description = "Nom du Gateway de l'application"
  type = string
}

variable "app_service_fqdn" {
  description = "FQDN de l'App service"
  type = string
}