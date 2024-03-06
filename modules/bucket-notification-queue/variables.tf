variable "queue_name" {
  type        = string
  description = "The name of the queue."
}

variable "processing_role_arn" {
  type        = string
  description = "The arn of the role that will be able to process events sent to the queue."

  validation {
    error_message = "The value must be the arn of an AWS role."
    condition     = can(regex("^arn:aws:iam::\\d{12}?:role/[\\w+=,.@-]{1,64}$", var.processing_role_arn))
  }
}

variable "publishing_bucket_arn" {
  type        = string
  description = "The arn of the S3 bucket that will publish events."

  validation {
    error_message = "The value must be the arn of an S3 bucket."
    condition     = can(regex("^arn:aws:s3:::[\\w+=,.@-]{3,63}$", var.publishing_bucket_arn))
  }
}


variable "tags" {
  type        = map(string)
  description = "A map of tags that will be applied to provisioned resources."
}
