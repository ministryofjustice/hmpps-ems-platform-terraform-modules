data "template_file" "cloudwatch_event_rule" {
  template = <<TEMPLATE
{
  "source": [
    "aws.guardduty"
  ],
  "detail-type": [
    "GuardDuty Finding"
  ]
}
TEMPLATE
}


resource "aws_cloudwatch_log_group" "this" {
  name = local.guardduty_log_group_name
  tags = var.tags
}


resource "aws_cloudwatch_event_rule" "this" {
  name          = local.guardduty_event_rule_name
  event_pattern = data.template_file.cloudwatch_event_rule.rendered
}


resource "aws_cloudwatch_event_target" "this" {
  target_id = local.guardduty_event_target_id
  rule      = aws_cloudwatch_event_rule.this.name
  arn       = aws_cloudwatch_log_group.this.arn
}