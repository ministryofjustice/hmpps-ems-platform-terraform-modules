variable "tags" {
  description = "A map of tags that will be applied to provisioned resources."
  type        = map(string)
}

variable "slack_username" {
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

variable "role_name" {
  description = "The name for the lambda role"
  type        = string
}