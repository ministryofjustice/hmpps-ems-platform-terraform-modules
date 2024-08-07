variable "create" {
  default     = true
  description = "Controls whether resources should be created."
  type        = bool
}

variable "pagerduty_integration_url" {
  type        = string
  description = "The pagerduty url to send data to."

  validation {
    error_message = "Url must contain the pagerduty domain."
    condition     = can(regex("^https:\\/\\/events\\.pagerduty\\.com\\/integration\\/[A-Za-z0-9]{32}\\/enqueue$", var.pagerduty_integration_url))
  }
}

variable "tags" {
  default     = {}
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
}
