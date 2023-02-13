output "SQLALCHEMY_DATABASE_URI" {
  value     = "postgresql+psycopg2://${var.administrator_login}:${var.administrator_login_password}@${azurerm_postgresql_server.db.fqdn}/${var.db_name}"
  sensitive = true
}

output "AZURE_POSTGRES_SERVER" {
  value = azurerm_postgresql_server.db.fqdn
}
