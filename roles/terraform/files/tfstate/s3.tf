resource "aws_s3_bucket" "tfstate" {
  bucket              = "${data.aws_caller_identity.current.account_id}-outline-lightsail-tfstate"
  object_lock_enabled = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_acl" "tfstate_acl" {
  bucket = aws_s3_bucket.tfstate.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "tfstate_versioning" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate_sse" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_object_lock_configuration" "tfstate_lock" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    default_retention {
      mode = "COMPLIANCE"
      days = 5
    }
  }
}

