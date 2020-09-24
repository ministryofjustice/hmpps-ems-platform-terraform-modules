variable "resource_name_prefix" {
  type        = string
  description = "This is the prefix that will be applied to all resources deployed by this module."
}


variable "tags" {
  type        = map(string)
  description = "A list of tags that will be applied to deployed resources."
}


locals {
  central_monitoring_iam_username = "${var.resource_name_prefix}-central-monitoring"
  cloudwatch_iam_role_name        = "${var.resource_name_prefix}-central-monitoring-role"
  cloudwatch_iam_policy_name      = "${var.resource_name_prefix}-central-monitoring-policy"
}
