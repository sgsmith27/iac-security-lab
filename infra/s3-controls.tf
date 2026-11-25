resource "aws_s3_bucket_versioning" "datos" {
  bucket = aws_s3_bucket.datos.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "datos" {
  bucket = aws_s3_bucket.datos.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = var.kms_key_arn
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_logging" "datos" {
  bucket        = aws_s3_bucket.datos.id
  target_bucket = var.access_logs_bucket_name
  target_prefix = "datos/"
}

resource "aws_s3_bucket_notification" "datos" {
  bucket      = aws_s3_bucket.datos.id
  eventbridge = true
}

resource "aws_s3_bucket_lifecycle_configuration" "datos" {
  bucket     = aws_s3_bucket.datos.id
  depends_on = [aws_s3_bucket_versioning.datos]
  rule {
    id     = "limpiar-versiones-y-cargas-incompletas"
    status = "Enabled"
    filter {
      prefix = ""
    }
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
    noncurrent_version_expiration {
      noncurrent_days = 365
    }
  }
}

# Replicacion entre regiones omitida mediante la excepcion RIESGO-001.
# La supresion se declara exclusivamente en aws_s3_bucket.datos (main.tf).
