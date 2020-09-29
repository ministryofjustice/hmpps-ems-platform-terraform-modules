variable resource_name_prefix {
  type        = string
  description = "This is the prefix that will be applied to all resources deployed by this module."
}


variable tags {
  type        = map(string)
  description = "A list of tags that will be applied to deployed resources."
}


locals {
  cloudwatch_event_rule_name = "${var.resource_name_prefix}-blackhole-monitor-rule"
  cloudwatch_event_target_id = "${var.resource_name_prefix}-blackhole-monitor-target"
  lambda_iam_policy_name     = "${var.resource_name_prefix}-blackhole-monitor-policy"
  lambda_iam_role_name       = "${var.resource_name_prefix}-blackhole-monitor-role"
  lambda_function_name       = "${var.resource_name_prefix}-blackhole-monitor"
  lambda_function_runtime    = "python3.8"
  lambda_function_timeout    = "600"
}
