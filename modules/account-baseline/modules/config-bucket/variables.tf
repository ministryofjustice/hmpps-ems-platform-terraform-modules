variable "resource_name_prefix" {
  type        = string
  description = "This is the prefix that will be applied to all resources deployed by this module."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags that will be applied to deployed resources."
}
