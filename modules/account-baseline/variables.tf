variable "enable_aws_config" {
  type        = string
  default     = true
  description = "Enable AWS config and NCSC conformance packs in the account."
}

variable "enable_ebs_encryption_by_default" {
  type        = bool
  default     = true
  description = "Enable EBS encryption by default in the account."
}

variable "enable_securityhub_standards" {
  type        = bool
  default     = true
  description = "Enable AWS and CIS SecurityHub standards in the account."
}

variable "enable_s3_account_public_access_block" {
  type        = bool
  default     = true
  description = "Enable s3 account level public access block in the account."
}

variable "provision_aws_support_role" {
  type        = bool
  default     = true
  description = "Provision a role for AWS Support in the account."
}

variable "provision_guardduty_detector" {
  type        = string
  default     = true
  description = "Provision GuardDuty detector in the account."
}

variable "resource_name_prefix" {
  type        = string
  description = "This is the prefix that will be applied to all resources deployed by this module."
}

variable "sl_firehose_destination_guardduty" {
  type        = string
  description = "The logging pipeline in the shared logging account to send guardduty findings to."
}

variable "tags" {
  type        = map(string)
  description = "A list of tags that will be applied to deployed resources."
}
