variable resource_name_prefix {
  type        = string
  description = "This is the prefix that will be applied to all resources deployed by this module."
}

variable enable_mock_response {
  type        = bool
  description = "Instruct the lamda to consume mock_vpn_connections.json rather than call the AWS"
  default     = false
}


variable tags {
  type        = map(string)
  description = "A list of tags that will be applied to deployed resources."
}


locals {
  role_name                  = "${var.resource_name_prefix}-vpn-monitor-role"
  role_policy_name           = "${var.resource_name_prefix}-vpn-monitor-policy"
  lambda_name                = "${var.resource_name_prefix}-vpn-monitor"
  dynamodb_table_name        = "${var.resource_name_prefix}-vpn-monitor-state-table"
  cloudwatch_event_rule_name = "${var.resource_name_prefix}-vpn-monitor-rule"
  cloudwatch_event_target_id = "${var.resource_name_prefix}-vpn-monitor-target"
  sns_topic_name             = "${var.resource_name_prefix}-vpn-monitor-topic"
}
