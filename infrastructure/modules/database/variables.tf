variable "resource_group_name" {
  description = "Le nom du groupe de ressources où créer les services."
  type = string
}

variable "database_subnet_id" {
  description = "L'ID du réseau virtuel pour la zone DNS."
  type = string
}

variable "vnet_id" {
  description = "L'ID du réseau virtuel pour la BDD."
  type = string

}
variable "physical_location" {
  description = "La localisation des services."
  type = string
}

variable "my_dns_zone_name" {
  description = "Le nom de la zone DNS."
  type = string
}

variable "my_dns_zone_link_name" {
  description = "Le nom de la zone DNS liée."
  type = string
}

variable "administrator_login" {
  description = "Le nom d'utilisateur administrateur de la BDD."
  type = string
}

variable "administrator_password" {
  description = "Le mot de passe administrateur de la BDD."
  type = string
}

variable "postgresql_db_name" {
  description = "Le nom de la base données à créer."
  type = string
}
