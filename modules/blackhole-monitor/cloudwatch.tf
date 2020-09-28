resource "aws_cloudwatch_event_rule" "this" {
  name                = local.cloudwatch_event_rule_name
  description         = "A rule that triggers the blackhole-monitor lambda on a configurable schedule"
  schedule_expression = "rate(5 minutes)"
  tags                = var.tags
}


resource "aws_cloudwatch_event_target" "this" {
  target_id = local.cloudwatch_event_target_id
  rule      = aws_cloudwatch_event_rule.this.name
  arn       = aws_lambda_function.this.arn
}
