resource "aws_sns_topic" "this" {
  count = var.create ? 1 : 0

  name = "hmpps-sn-p-alarms-topic"

  tags = var.tags
}

resource "aws_sns_topic_subscription" "this" {
  count = var.create ? 1 : 0

  topic_arn              = aws_sns_topic.this[0].arn
  protocol               = "https"
  endpoint               = var.pagerduty_integration_url
  endpoint_auto_confirms = true
}
