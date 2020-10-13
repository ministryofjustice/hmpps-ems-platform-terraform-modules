data "template_file" "cloudwatch_event_rule" {
  template = <<TEMPLATE
{
  "source": [
    "aws.guardduty"
  ]
}
TEMPLATE
}


resource "aws_cloudwatch_log_group" "this" {
  name = local.cloudwatch_log_group_name
  tags = var.tags
}


resource "aws_cloudwatch_event_rule" "this" {
  name          = local.cloudwatch_event_rule_name
  event_pattern = data.template_file.cloudwatch_event_rule.rendered
  role_arn      = aws_iam_role.cloudwatch.arn
  tags          = var.tags
}


resource "aws_cloudwatch_event_target" "this" {
  target_id = local.cloudwatch_event_target_id
  rule      = aws_cloudwatch_event_rule.this.name
  arn       = aws_cloudwatch_log_group.this.arn
}


resource "aws_cloudwatch_log_subscription_filter" "this" {
  name            = local.cloudwatch_log_group_name
  log_group_name  = aws_cloudwatch_log_group.this.name
  filter_pattern  = ""
  destination_arn = var.sl_firehose_destination_guardduty
}
