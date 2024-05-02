variable "current_account" {
  description = "Account number for use in the arns"
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "A map of tags that will be applied to provisioned resources."
}