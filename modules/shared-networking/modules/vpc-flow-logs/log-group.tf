resource "aws_cloudwatch_log_group" "this" {
  name = local.cloudwatch_log_group_name
  tags = var.tags
}


resource "aws_cloudwatch_log_subscription_filter" "this" {
  name            = local.cloudwatch_log_subscription_filter_name
  log_group_name  = aws_cloudwatch_log_group.this.name
  filter_pattern  = ""
  destination_arn = var.cloudwatch_destination_arn
}
