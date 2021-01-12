variable "group_name" {
  type        = string
  description = "The name of the group."
}


variable "path" {
  type        = string
  description = "The path to assign to the created group."
  default     = "/"
}


variable "policy_arns" {
  type        = list(string)
  description = "A list of policy arn's that will be attached to the group."
  default     = []
}
