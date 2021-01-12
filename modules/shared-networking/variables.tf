variable "vpc_name" {
  type        = string
  description = "The name of the VPC."
}


variable "resource_name_prefix" {
  type        = string
  description = "This is the prefix that will be applied to all resources deployed by this module."
}


variable "cloudwatch_destination_arn" {
  type        = string
  description = "The arn of the cloudwatch destination that logs will be forwarded to."
}


variable "tags" {
  type        = map(string)
  description = "A map of common tags to apply to the resources."
}
