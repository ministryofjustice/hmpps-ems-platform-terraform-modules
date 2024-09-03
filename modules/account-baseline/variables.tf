variable "resource_name_prefix" {
  type        = string
  description = "This is the prefix that will be applied to all resources deployed by this module."
}

variable "sl_firehose_destination_guardduty" {
  type = string
}

variable "provision_guardduty_detector" {
  type    = string
  default = true
}

variable "tags" {
  type        = map(string)
  description = "A list of tags that will be applied to deployed resources."
}

variable "create_aws_support_role" {
  type    = bool
  default = true
}

variable "enable_aws_config" {
  type    = string
  default = false
}

variable "enable_securityhub_standards" {
  type    = bool
  default = false
}

variable "enable_ebs_encryption_by_default" {
  type    = bool
  default = false
}

variable "enable_s3_account_public_access_block" {
  type    = bool
  default = false
}
