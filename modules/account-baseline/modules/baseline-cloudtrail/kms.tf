resource "aws_kms_key" "this" {
  is_enabled               = true
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  deletion_window_in_days  = 30
  # policy =
  tags = var.tags
}

resource "aws_kms_alias" "this" {
  name          = "alias/${local.cloudtrail_kms_key_alias_name}"
  target_key_id = aws_kms_key.this.key_id
}
