variable "resource_name_prefix" {
  type        = string
  description = "This is the prefix that will be applied to all resources deployed by this module."
}

variable "config_bucket_name" {
  type        = string
  description = "The name of the S3 bucket used to store the configuration history."
}

variable "config_service_role" {
  type        = string
  description = "Used to make read or write requests to the delivery channel and to describe the AWS resources associated with the account."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags that will be applied to deployed resources."
}
