variable "docker_registry_password" {
  description = "Le mot de passe du registre Docker."
  type        = string
}

variable "gateway_subnet_name" {
  description = "Le nom du sous-réseau pour la passerelle."
  type        = string
  default     = "gateway-subnet"
}

variable "service_plan_name" {
  description = "Le nom du plan de service."
  type        = string
  default     = "project_service_plan"
}

variable "administrator_password" {
  description = "Le mot de passe administrateur pour la base de données. Assurez-vous qu'il respecte les exigences Azure."
  type        = string
  sensitive   = true
}

variable "resource_group_name" {
  description = "Le nom que vous souhaitez donner au groupe de ressources."
  type        = string
  default     = "CloudProject"
}

variable "docker_image" {
  description = "L'image Docker à déployer."
  type        = string
  default     = "ghcr.io/theoprz/junia-isen-examples-api:latest"
}

variable "postgresql_db_name" {
  description = "Le nom de la base de données PostgreSQL."
  type        = string
  default     = "isenprojectclouddatabase"
}

variable "docker_registry_url" {
  description = "L'URL du registre Docker."
  type        = string
  default     = "https://ghcr.io"
}

variable "vnet_name" {
  description = "Le nom que vous souhaitez donner au réseau virtuel (VNet)."
  type        = string
  default     = "vnet1"
}

variable "gateway_subnet_address_prefixes" {
  description = "Les préfixes d'adresses pour le sous-réseau de la passerelle."
  type        = list(string)
  default     = ["10.0.3.0/24"]
}

variable "physical_location" {
  description = "La région où le groupe de ressources sera créé. Pour les comptes étudiants -> France Central."
  type        = string
  default     = "France Central"
}

variable "docker_registry_username" {
  description = "Le nom d'utilisateur pour le registre Docker."
  type        = string
  default     = "theoprz"
}

variable "app_service_name" {
  description = "Le nom du service applicatif."
  type        = string
  default     = "isenprojectcloudapp"
}

variable "my_dns_zone_name" {
  description = "Le nom de la zone DNS privée. Doit être un nom de domaine valide."
  type        = string
  default     = "mydnszone.postgres.database.azure.com"
}

variable "administrator_login" {
  description = "Le nom d'utilisateur administrateur pour la base de données."
  type        = string
  sensitive   = true
}

variable "application_gateway_name" {
  description = "Le nom de la passerelle d'application."
  type        = string
  default     = "isenprojectcloudgateway"
}

variable "vnet_address_space" {
  description = "L'espace d'adressage du réseau virtuel."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "database_subnet_name" {
  description = "Le nom que vous souhaitez donner au sous-réseau pour la base de données."
  type = string
  default = "db-subnet"
}

variable "database_subnet_address_prefixes" {
  description = "L'espace d'adressage pour le sous-réseau de la base de données."
  type = list(string)
  default = ["10.0.1.0/24"]
}

variable "my_dns_zone_link_name" {
  description = "Le nom que vous souhaitez donner au lien de la zone DNS."
  type = string
  default = "mydnszonelink"
}


variable "app_subnet_address_prefixes" {
  description = "Les préfixes d'adresses pour le sous-réseau de l'application."
  type = list(string)
  default = ["10.0.2.0/24"]
}

variable "app_subnet_name" {
  description = "Le nom que vous souhaitez donner au sous-réseau pour l'application."
  type = string
  default = "web-app-subnet"
}

variable "public_ip_name" {
  description = "Le nom de l'adresse IP publique."
  type = string
  default = "isenprojectcloudip"
}

variable "subscription_id" {
  description = "Votre ID d'abonnement Azure. Utilisez 'az account list --output table' ou 'az login' pour l'obtenir."
  type = string
  sensitive = true
}

variable "new_relic_license_key" {
  description = "La clé de licence New Relic à utiliser pour la surveillance."
  type = string
  default = ""
}