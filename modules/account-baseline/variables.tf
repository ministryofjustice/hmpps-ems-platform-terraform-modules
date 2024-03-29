variable "resource_name_prefix" {
  type        = string
  description = "This is the prefix that will be applied to all resources deployed by this module."
}

variable "sl_firehose_destination_guardduty" {
  type = string
}

variable "provision_guardduty_detector" {
  type    = string
  default = true
}

variable "tags" {
  type        = map(string)
  description = "A list of tags that will be applied to deployed resources."
}

variable "enable_aws_config" {
  type    = string
  default = false
}
