# --- Trigger the lambda every 5 minutes
resource "aws_cloudwatch_event_rule" "this" {
  name          = local.cloudwatch_event_rule_name
  description   = "A rule that triggers the lambda given an event pattern"
  event_pattern = var.trigger_event_json
  tags          = var.tags
}


resource "aws_cloudwatch_event_target" "this" {
  target_id = local.cloudwatch_event_target_id
  rule      = aws_cloudwatch_event_rule.this.name
  arn       = aws_lambda_function.this.arn
}


resource "aws_lambda_permission" "this" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this.arn
}
