resource "aws_secretsmanager_secret" "db_credentials" {
  name                    = "app/db/credentials"
  recovery_window_in_days = 0 # Force immediate deletion on destroy
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    engine   = "mysql"
    host     = aws_db_instance.app_db.address
    port     = aws_db_instance.app_db.port
    dbname   = var.db_name
  })
}