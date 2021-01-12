variable "vpc_name" {
  type        = string
  description = "The id of the VPC."
}


variable "resource_name_prefix" {
  type        = string
  description = "This is the prefix that will be applied to all resources deployed by this module."
}


variable "cloudwatch_destination_arn" {
  type        = string
  description = "The arn of the cloudwatch destination that logs will be forwarded to."
}


variable "tags" {
  type        = map(string)
  description = "A map of common tags to apply to the resources."
}


locals {
  cloudwatch_role_name                    = "${var.resource_name_prefix}-vpc-flowlogs-cloudwatch-role"
  cloudwatch_role_policy_name             = "${var.resource_name_prefix}-vpc-flowlogs-cloudwatch-policy"
  cloudwatch_log_group_name               = "${var.resource_name_prefix}-vpc-flowlogs-log-group"
  cloudwatch_log_subscription_filter_name = "${var.resource_name_prefix}-vpc-flowlogs-log-subscription"
}
