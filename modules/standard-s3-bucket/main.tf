
data "aws_iam_policy_document" "this" {
  source_json = var.policy
  statement {
    sid = "DenyInsecureTransport"
    actions = [
      "s3:*"
    ]

    effect = "Deny"

    principals {
      type = "*"
      identifiers = [
        "*"
      ]
    }

    resources = [
      "arn:aws:s3:::${var.name}/*"
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = [
        "false"
      ]
    }
  }
}

resource "aws_s3_bucket" "this" {
  bucket = var.name
  acl    = var.acl
  policy = data.aws_iam_policy_document.this.json
  tags   = var.tags

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_enabled ? [1] : []
    content {

      enabled = var.lifecycle_enabled
      id      = "${var.name}-lifecycle"

      transition {
        days          = var.lifecycle_standard_transition_days
        storage_class = "STANDARD_IA"
      }

      transition {
        days          = var.lifecycle_glacier_transition_days
        storage_class = "GLACIER"
      }

      noncurrent_version_transition {
        days          = var.lifecycle_standard_noncurrent_transition_days
        storage_class = "STANDARD_IA"
      }

      noncurrent_version_transition {
        days          = var.lifecycle_glacier_noncurrent_transition_days
        storage_class = "GLACIER"
      }

      expiration {
        days = var.lifecycle_expiration_days
      }

      noncurrent_version_expiration {
        days = var.lifecycle_noncurrent_expiration_days
      }
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_s3_bucket_public_access_block" "this" {
  count  = var.block_public_access ? 1 : 0
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_ownership_controls" "this" {
  count  = var.object_ownership != "" ? 1 : 0
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = var.object_ownership
  }
}
