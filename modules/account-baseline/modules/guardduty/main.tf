locals {
  cloudwatch_log_group_name                 = "/aws/events/${var.resource_name_prefix}-guardduty-log-group"
  cloudwatch_log_group_resource_policy_name = "${var.resource_name_prefix}-guardduty-log-group-resource-policy"
  cloudwatch_event_rule_name                = "${var.resource_name_prefix}-guardduty-event-rule"
  cloudwatch_event_target_id                = "${var.resource_name_prefix}-guardduty-event-target"
}
