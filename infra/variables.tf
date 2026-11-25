# Dependencias externas: no hay valores ficticios ni secretos por defecto.
# El analisis estatico no requiere proporcionar estos valores ni acceder a AWS.
variable "vpc_id" {
  description = "VPC existente que contiene las subredes privadas de RDS."
  type        = string
}

variable "db_subnet_group_name" {
  description = "Grupo existente de subredes privadas en al menos dos zonas de esa VPC."
  type        = string
}

variable "kms_key_arn" {
  description = "Clave KMS existente en us-east-1, habilitada, con rotacion y permisos para S3 y RDS."
  type        = string
}

variable "rds_monitoring_role_arn" {
  description = "Rol existente de Enhanced Monitoring con confianza en monitoring.rds.amazonaws.com."
  type        = string
}

variable "access_logs_bucket_name" {
  description = "Bucket existente de auditoria en la misma region y cuenta, con politica de entrega de logs S3."
  type        = string
}

variable "replication_role_arn" {
  description = "Rol existente de replicacion S3 con confianza, lectura de origen, escritura en destino y permisos KMS."
  type        = string
}

variable "replica_bucket_arn" {
  description = "Bucket existente en otra region, privado y con versionado, politica de replicacion y cifrado."
  type        = string
}

variable "replica_kms_key_arn" {
  description = "Clave KMS existente en la region destino con politica que permita la replicacion."
  type        = string
}
