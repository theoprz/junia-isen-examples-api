output "postgresql_host" {
  value = azurerm_postgresql_flexible_server.my_postgresql_server.fqdn
}

output "postgresql_port" {
  value = 5432
}

output "postgresql_db_name" {
  value = azurerm_postgresql_flexible_server_database.my_db.name
}

output "postgresql_administrator_login" {
  value = azurerm_postgresql_flexible_server.my_postgresql_server.administrator_login
  sensitive = true
}

output "postgresql_administrator_password" {
  value = var.administrator_password
  sensitive = true
}
