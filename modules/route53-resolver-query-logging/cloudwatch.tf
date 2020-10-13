resource "aws_cloudwatch_log_group" "this" {
  name = local.cloudwatch_log_group_name
  tags = var.tags
}
