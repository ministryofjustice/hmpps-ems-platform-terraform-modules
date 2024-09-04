variable "role_name" {
  default     = "support"
  description = "Name of the role to create"
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to apply to resources, where applicable"
  type        = map(any)
}
