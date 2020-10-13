variable "resource_name_prefix" {
  type        = string
  description = "This is the prefix that will be applied to all resources deployed by this module."
}


variable "vpc_id" {
  type        = string
  description = "The VPC to assosiacate to"
}


variable "tags" {
  type        = map(string)
  description = "A list of tags that will be applied to deployed resources."
}


locals {
  cloudwatch_log_group_name     = "${var.resource_name_prefix}-route53-resolver-query-logging-log-group"
  route53_query_log_config_name = "${var.resource_name_prefix}-route53-resolver-query-log"
}
