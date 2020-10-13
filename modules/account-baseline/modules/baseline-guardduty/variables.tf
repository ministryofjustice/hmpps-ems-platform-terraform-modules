variable "resource_name_prefix" {
  type        = string
  description = "This is the prefix that will be applied to all resources deployed by this module."
}


variable "tags" {
  type        = map(string)
  description = "A list of tags that will be applied to deployed resources."
}


variable "enable_collector" {
  type        = string
  description = "Enable monitoring and feedback reporting"
  default     = true
}

variable "publishing_frequency" {
  type        = string
  description = "Specifies the frequency of notifications sent for subsequent finding occurrences"
  default     = "FIFTEEN_MINUTES"
}


locals {
  guardduty_log_group_name  = "${var.resource_name_prefix}-guardduty-log-group"
  guardduty_event_rule_name = "${var.resource_name_prefix}-guardduty-event-rule"
  guardduty_event_target_id = "${var.resource_name_prefix}-guardduty-event-target"
}
