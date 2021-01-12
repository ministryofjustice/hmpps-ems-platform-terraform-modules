locals {
  # --- These are the default policies that will be attached to every role
  # --- created with this module.
  default_policy_arns = [
  ]
}

variable "role_name" {
  type        = string
  description = "The name of the role."
}

variable "role_description" {
  type        = string
  description = "A description for the role"
  default     = ""
}

variable "path" {
  type        = string
  description = "The path to assign to the created user."
  default     = "/"
}

variable "iam_account_id" {
  type        = string
  description = "The id of the main iam account."
}

variable "policy_arns" {
  type        = list(string)
  description = "A list of policy arn's that will be attached to the role."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "A list of tags that will be applied to deployed resources."
}
