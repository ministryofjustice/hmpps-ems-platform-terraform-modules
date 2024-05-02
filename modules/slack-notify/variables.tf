variable "account_number" {
  description = "Account number for use in the arns"
  type        = string
}

variable "tags" {
  description = "A map of tags that will be applied to provisioned resources."
  type        = map(string)
}

variable "current_account" {
  description = "Account name prefix"
  type        = string
}

variable "slack_webhook_url" {
  description = "Webhook URL for slack channel"
  type        = string
}

variable "slack_channel" {
  description = "Username for account on slack"
  type        = string
}