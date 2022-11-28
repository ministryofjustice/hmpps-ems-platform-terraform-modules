variable "resource_name_prefix" {
  type        = string
  description = "This is the prefix that will be applied to all resources deployed by this module."
}


variable "service_name" {
  type        = string
  description = "The name of the service that this resource is going to support (e.g. vpn-monitor or central-log-store)."
}


variable "source_dir" {
  type        = string
  description = "The directory that conatins the lambda source code."
}


variable "output_path" {
  type        = string
  description = "The directory where the archived lambda package will be created."
}


variable "handler" {
  type        = string
  description = "The path to the lambda handler (e.g my_file.my_function). The default is app.handler.run."
  default     = "app.handler.run"
}


variable "runtime" {
  type        = string
  description = "The runtime for the lambda function. Default is python3.8"
  default     = "python3.8"
}


variable "timeout" {
  type        = number
  description = "The timeout for the lambda function. Default is 600."
  default     = 600
}


variable "environment_variables" {
  type        = map(string)
  description = "A map of environment variables."
  default     = {}
}


variable "trigger_event" {
  type        = object
  description = "Defines how often the lambda function will trigger."
}


variable "iam_policy" {
  type        = string
  description = "A policy document representing the policy that will be associated with the lambdas role."
}


variable "tags" {
  type        = map(string)
  description = "A list of tags that will be applied to deployed resources."
}


locals {
  lambda_name                = "${var.resource_name_prefix}-${var.service_name}-lambda"
  role_name                  = "${var.resource_name_prefix}-${var.service_name}-role"
  role_policy_name           = "${var.resource_name_prefix}-${var.service_name}-policy"
  cloudwatch_event_rule_name = "${var.resource_name_prefix}-${var.service_name}-rule"
  cloudwatch_event_target_id = "${var.resource_name_prefix}-${var.service_name}-target"
}
