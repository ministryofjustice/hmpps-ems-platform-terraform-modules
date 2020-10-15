resource "aws_cloudtrail" "cloudtrail" {
  name                          = local.cloudtrail_name
  s3_bucket_name                = module.cloudtrail_s3.id
  include_global_service_events = true
  enable_log_file_validation    = true
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.cloudwatch.arn}:*"
  cloud_watch_logs_role_arn     = aws_iam_role.cloudwatch.arn
  kms_key_id                    = aws_kms_key.this.arn
  tags                          = var.tags
}
