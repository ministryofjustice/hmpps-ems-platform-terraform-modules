variable "resource_name_prefix" {
  type        = string
  description = "This is the prefix that will be applied to all resources deployed by this module."
}


variable "sl_firehose_destination_cloudtrail" {
  type = string
}


variable "tags" {
  type        = map(string)
  description = "A list of tags that will be applied to deployed resources."
}


variable "cloudtrail_s3_bucket_force_destroy" {
  type        = string
  description = "This determines wether the S3 bucket contents will be destroyed prior to the bucket being deleted"
  default     = "false"
}


locals {
  cloudtrail_name               = "${var.resource_name_prefix}-cloudtrail"
  cloudtrail_s3_bucket_name     = "${var.resource_name_prefix}-cloudtrail-bucket"
  cloudwatch_log_group_name     = "${var.resource_name_prefix}-cloudtrail-log-group"
  cloudwatch_log_stream_name    = "${var.resource_name_prefix}-cloudtrail-log-stream"
  cloudwatch_iam_role_name      = "${var.resource_name_prefix}-cloudtrail-role"
  cloudwatch_iam_policy_name    = "${var.resource_name_prefix}-cloudtrail-policy"
  cloudtrail_kms_key_alias_name = "${var.resource_name_prefix}-kms-key"
}
