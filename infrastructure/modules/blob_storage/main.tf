resource "random_string" "my_random_storage_name" {
  # Génération d'un nom aléatoire --------------------
  # Crée une chaîne aléatoire de 10 caractères pour garantir que le nom du compte de stockage est unique.
  length  = 10 # Longueur de la chaîne
  special = false # Pas de caractères spéciaux
  upper = false # Pas de majuscules
}

resource "azurerm_storage_account" "storage_account" {
  # Compte de stockage Azure -------------------------
  # Crée un compte de stockage pour héberger les blobs.
  name = "projectblobexample${random_string.my_random_storage_name.result}" # Nom unique
  resource_group_name = var.resource_group_name
  location = var.physical_location
  account_tier = "Standard" # Niveau de service : Standard
  account_replication_type = "LRS" # Réplication locale (Local Redundant Storage)
}

resource "azurerm_storage_container" "storage_container" {
  # Conteneur de stockage ----------------------------
  # Définit un conteneur dans le compte de stockage pour organiser les blobs.
  name = "api" # Nom du conteneur
  storage_account_name = azurerm_storage_account.storage_account.name
  container_access_type = "private" # Accès privé pour des raisons de sécurité
}

resource "azurerm_storage_blob" "blob_storage" {
  # Blob de stockage Azure ---------------------------
  # Charge un fichier local (quotes.json) dans le conteneur.
  name = "quotes.json" # Nom du blob dans le conteneur
  source = "${path.module}/quotes.json" # Chemin vers le fichier source local
  storage_account_name = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.storage_container.name
  type = "Block" # Type de blob : bloc
}