# --- Trigger the lambda every 5 minutes
resource "aws_cloudwatch_event_rule" "this" {
  count = var.enable_schedule ? 1 : 0

  name                = local.cloudwatch_event_rule_name
  description         = "A rule that triggers the lambda on a configurable schedule"
  schedule_expression = var.trigger_schedule
  tags                = var.tags
}


resource "aws_cloudwatch_event_target" "this" {
  count = var.enable_schedule ? 1 : 0

  target_id = local.cloudwatch_event_target_id
  rule      = aws_cloudwatch_event_rule.this[0].name
  arn       = aws_lambda_function.this.arn
}


resource "aws_lambda_permission" "this" {
  count = var.enable_schedule ? 1 : 0

  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this[0].arn
}
