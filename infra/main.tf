# Configuracion deliberadamente insegura para analisis estatico.
# No ejecutar terraform apply. La credencial es ficticia.
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "datos" {
  bucket = "galileo-demo-datos"
}

resource "aws_s3_bucket_public_access_block" "datos" {
  bucket                  = aws_s3_bucket.datos.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_security_group" "web" {
  name        = "web"
  description = "Acceso al servidor web"
  ingress {
    description = "SSH desde cualquier lugar"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "db" {
  identifier          = "demo-db"
  engine              = "postgres"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  username            = "admin"
  password            = "SuperSecreta123"
  publicly_accessible = true
  storage_encrypted   = false
  skip_final_snapshot = true
}
