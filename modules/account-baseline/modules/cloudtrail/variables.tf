variable "resource_name_prefix" {
  type        = string
  description = "This is the prefix that will be applied to all resources deployed by this module."
}

variable "tags" {
  type        = map(string)
  description = "A list of tags that will be applied to deployed resources."
}


locals {
  cloudtrail_name               = "${var.resource_name_prefix}-cloudtrail"
  cloudwatch_log_group_name     = "${var.resource_name_prefix}-cloudtrail-log-group"
  cloudwatch_iam_role_name      = "${var.resource_name_prefix}-cloudtrail-role"
  cloudwatch_iam_policy_name    = "${var.resource_name_prefix}-cloudtrail-policy"
  cloudtrail_kms_key_alias_name = "${var.resource_name_prefix}-cloudtrail-kms-key"
}
