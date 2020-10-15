data "aws_iam_policy_document" "kms" {
  statement {
    sid     = "EnableIAMUserPermissions"
    effect  = "Allow"
    actions = ["kms:*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    resources = ["*"]
  }
  statement {
    sid     = "AllowCloudWatchLogsGroup"
    effect  = "Allow"
    actions = ["kms:Encrypt*", "kms:Decrypt*", "kms:ReEncrypt*", "kms:GenerateDataKey*", "kms:Describe*"]
    principals {
      type        = "AWS"
      identifiers = ["logs.${data.aws_region.current.name}.amazonaws.com"]
    }
    resources = ["*"]
  }
}

resource "aws_kms_key" "this" {
  is_enabled               = true
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation      = true
  deletion_window_in_days  = 30
  policy                   = data.aws_iam_policy_document.kms.json
  tags                     = var.tags
}

resource "aws_kms_alias" "this" {
  name          = "alias/${local.cloudtrail_kms_key_alias_name}"
  target_key_id = aws_kms_key.this.key_id
}
