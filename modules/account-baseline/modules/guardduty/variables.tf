variable "enable_collector" {
  type        = string
  description = "Enable monitoring and feedback reporting"
  default     = true
}

variable "provision_guardduty_detector" {
  type    = string
  default = true
}

variable "publishing_frequency" {
  type        = string
  description = "Specifies the frequency of notifications sent for subsequent finding occurrences"
  default     = "FIFTEEN_MINUTES"
}

variable "resource_name_prefix" {
  type        = string
  description = "This is the prefix that will be applied to all resources deployed by this module."
}

variable "sl_firehose_destination_guardduty" {
  type = string
}

variable "tags" {
  type        = map(string)
  description = "A list of tags that will be applied to deployed resources."
}
