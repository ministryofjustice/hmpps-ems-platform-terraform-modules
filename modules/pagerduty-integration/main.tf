resource "aws_sns_topic" "this" {
  name = "hmpps-sn-p-alarms-topic"

  tags = var.tags
}

resource "aws_sns_topic_subscription" "this" {
  topic_arn              = aws_sns_topic.this.arn
  protocol               = "https"
  endpoint               = var.pagerduty_integration_url
  endpoint_auto_confirms = true
}
