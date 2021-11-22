variable "name" {
  type        = string
  description = "The name of the bucket."
}


variable "acl" {
  type        = string
  description = "Sets the bucket ACL."
  default     = "private"
}


variable "policy" {
  type        = string
  description = "An additional policy that will be applied to the bucket."
  default     = ""
}

variable "block_public_access" {
  type        = bool
  description = "Enable or disable bucket public access."
  default     = true
}


variable "lifecycle_enabled" {
  type        = bool
  description = "Enable or disable s3 lifecycle."
  default     = false
}


variable "lifecycle_standard_transition_days" {
  type        = string
  description = "Number of days before objects are transitioned to the STANDARD_IA storage class."
  default     = "30"
}


variable "lifecycle_glacier_transition_days" {
  type        = string
  description = "Number of days before objects are transitioned to the GLACIER storage class."
  default     = "60"
}


variable "lifecycle_standard_noncurrent_transition_days" {
  type        = string
  description = "Number of days before noncurrent objects are transitioned to the STANDARD_IA storage class."
  default     = "30"
}


variable "lifecycle_glacier_noncurrent_transition_days" {
  type        = string
  description = "Number of days before noncurrent objects are transitioned to the GLACIER storage class."
  default     = "60"
}


variable "lifecycle_expiration_days" {
  type        = string
  description = "Number of days before objects are expired."
  default     = "425"
}


variable "lifecycle_noncurrent_expiration_days" {
  type        = string
  description = "Number of days before noncurrent objects are expired."
  default     = "425"
}


variable "object_ownership" {
  type        = string
  description = "Specify preferred object ownership."
  default     = ""
}


variable "bucket_versioning_enabled" {
  type        = bool
  description = "Enable S3 bucket versioning"
  default     = false
}


variable "tags" {
  type        = map(string)
  description = "A map of common tags to apply to the resources."
}
