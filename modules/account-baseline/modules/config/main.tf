locals {
  config_recorder_name         = "${var.resource_name_prefix}-config-recorder"
  config_delivery_channel_name = "${var.resource_name_prefix}-config-delivery-channel"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
