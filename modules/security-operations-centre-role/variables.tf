variable "name_prefix" {
  description = "Account name prefix to add to all resource names."
  type        = string
}

variable "enable_security_hub_access" {
  description = "Attach a policy statement that enables access to the security hub api."
  type        = bool
  default     = false
}

variable "enable_ec2_asset_collection" {
  description = "Attach a policy statement that enables access to ec2 metadata"
  type        = bool
  default     = false
}

variable "enable_guardduty_access" {
  description = "Attach a policy statement that enables access to the Guard Duty API"
  type        = bool
  default     = false
}

variable "s3_access" {
  description = "Attach a policy to the role that enables access to the specified S3 buckets and allows decyption of S3 objects."
  type = object({
    enabled     = bool
    bucket_arns = list(string)
    kms_keys    = list(string)
  })
  default = {
    enabled     = false
    bucket_arns = []
    kms_keys    = []
  }
}

variable "security_operations_centre_aws_principal" {
  description = "The ARN of the AWS principal that can assume this role."
  type        = string
  default     = "arn:aws:iam::812422902288:user/cumulo-aws-api-user" # E2E-Assure service user

  validation {
    error_message = "The value must be the arn of an AWS user."
    condition     = can(regex("^arn:aws:iam::\\d{12}?:user/[\\w+=,.@-]{1,64}$", var.security_operations_centre_aws_principal))
  }
}

variable "sqs_access" {
  description = "Attach a policy to the role that enables access to the specified SQS queues"
  type = object({
    enabled    = bool
    queue_arns = list(string)
  })
  default = {
    enabled    = false
    queue_arns = []
  }
}

variable "tags" {
  type        = map(string)
  description = "A map of tags that will be applied to provisioned resources."
}
