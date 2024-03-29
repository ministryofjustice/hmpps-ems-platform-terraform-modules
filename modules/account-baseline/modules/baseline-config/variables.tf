variable "resource_name_prefix" {
  type        = string
  description = "This is the prefix that will be applied to all resources deployed by this module."
}

variable "tags" {
  type        = map(string)
  description = "A list of tags that will be applied to deployed resources."
}

locals {
  config_s3_bucket_name        = "${var.resource_name_prefix}-config"
  config_iam_role_name         = "${var.resource_name_prefix}-config-role"
  config_iam_policy_name       = "${var.resource_name_prefix}-config-policy"
  config_recorder_name         = "${var.resource_name_prefix}-config-recorder"
  config_delivery_channel_name = "${var.resource_name_prefix}-config-delivery-channel"
}

