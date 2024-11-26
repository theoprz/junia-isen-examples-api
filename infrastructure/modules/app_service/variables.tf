variable "resource_group_name" {
  description = "Le nom du groupe de ressources de la base de données."
  type = string
}

variable "service_plan_name" {
  description = "Le nom du Service Plan"
  type = string
}

variable "physical_location" {
  description = "Emplacement physique des serveurs"
  type = string
}

variable "app_subnet_id" {
  description = "L'ID du sous-réseau"
  type = string
}

variable "docker_registry_password" {
  description = "Le mot de passe du registre Docker"
  type = string
  sensitive = true
}

variable "docker_image" {
  description = "La dernière image du Docker du projet"
  type = string
}

variable "docker_registry_url" {
  description = "L'URL du registre Docker"
  type = string

}
variable "docker_registry_username" {
  description = "Le nom d'utilisateur du registre Docker"
  type = string
  sensitive = true
}

variable "app_service_name" {
  description = "Le nom de l'App Service"
  type = string
}

variable "database_host" {
  description = "L'hôte de la BDD"
  type = string
}

variable "database_port" {
  description = "Le port de la BDD"
  type = string
}

variable "database_name" {
  description = "Le nom de la BDD"
  type = string
}

variable "database_user" {
  description = "Le nom d'utilisateur de la BDD"
  type = string
}

variable "database_password" {
  description = "Le mot de passe de la BDD"
  type = string
  sensitive = true
}

variable "storage_url" {
  description = "L'URL du blob storage"
  type = string
}

variable "storage_account_id" {
  description = "L'ID de compte de stockage"
  type = string
}

variable "new_relic_license_key" {
  description = "La nouvelle clé de license pour New Relic (Monitoring)"
  type = string
}
