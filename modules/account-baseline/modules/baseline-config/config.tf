data "aws_iam_role" "service_linked_role" {
  name = "AWSServiceRoleForConfig"
}

resource "aws_config_configuration_recorder" "this" {
  name     = local.config_recorder_name
  role_arn = data.aws_iam_role.service_linked_role.arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

resource "aws_config_delivery_channel" "this" {
  name           = local.config_delivery_channel_name
  s3_bucket_name = module.config_s3_bucket.id

  depends_on     = [
    aws_config_configuration_recorder.this
  ]
}

resource "aws_config_configuration_recorder_status" "this" {
  name       = aws_config_configuration_recorder.this.name
  is_enabled = true

  depends_on = [
    aws_config_delivery_channel.this
  ]
}
