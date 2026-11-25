# Laboratorio de analisis estatico. No ejecutar terraform apply.
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "datos" {
  bucket = "galileo-demo-datos"
}

resource "aws_s3_bucket_public_access_block" "datos" {
  bucket                  = aws_s3_bucket.datos.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_security_group" "web" {
  # Se conserva la direccion Terraform para comparar con la linea base.
  name        = "demo-db"
  description = "PostgreSQL desde la red privada de la aplicacion"
  vpc_id      = var.vpc_id
  ingress {
    description = "PostgreSQL desde la red privada de ejemplo"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.0/24"]
  }
}

resource "aws_db_instance" "db" {
  identifier          = "demo-db"
  engine              = "postgres"
  engine_version      = "16"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  username            = "admin"
  manage_master_user_password = true
  publicly_accessible        = false
  storage_encrypted          = true
  deletion_protection        = true
  backup_retention_period    = 7
  skip_final_snapshot        = false
  final_snapshot_identifier  = "demo-db-final"
  vpc_security_group_ids     = [aws_security_group.web.id]
  db_subnet_group_name       = var.db_subnet_group_name
  kms_key_id                 = var.kms_key_arn
  multi_az                   = true
  iam_database_authentication_enabled = true
  auto_minor_version_upgrade = true
  copy_tags_to_snapshot      = true
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  performance_insights_enabled = true
  performance_insights_kms_key_id = var.kms_key_arn
  monitoring_interval        = 60
  monitoring_role_arn        = var.rds_monitoring_role_arn
  parameter_group_name       = aws_db_parameter_group.db.name
}
