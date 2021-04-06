resource "aws_cloudtrail" "cloudtrail" {
  name                          = local.cloudtrail_name
  s3_bucket_name                = "hmpps-sl-awscloudtrail-log-bucket" // TODO - https://github.com/ministryofjustice/hmpps-ems-platform-terraform-modules/issues/22
  include_global_service_events = true
  enable_log_file_validation    = true
  is_multi_region_trail         = true
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.cloudwatch.arn}:*"
  cloud_watch_logs_role_arn     = aws_iam_role.cloudwatch.arn
  kms_key_id                    = aws_kms_key.this.arn
  event_selector {
    include_management_events = true
    read_write_type           = "All"

    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3"]
    }
    data_resource {
      type   = "AWS::Lambda::Function"
      values = ["arn:aws:lambda"]
    }
  }
  tags = var.tags
}
