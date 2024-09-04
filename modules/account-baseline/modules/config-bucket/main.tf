locals {
  bucket_name = "${var.resource_name_prefix}-config"
}

data "aws_caller_identity" "current" {}
