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
  name        = "web"
  description = "Acceso al servidor web"
  ingress {
    description = "SSH desde la red de administracion de ejemplo"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.0/24"]
  }
}

resource "aws_db_instance" "db" {
  identifier          = "demo-db"
  engine              = "postgres"
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
}
