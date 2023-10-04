resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name        = var.alarm_name
  alarm_description = "Run-book: ${var.runbook_url}"
  actions_enabled   = true

  alarm_actions             = var.alarm_actions
  ok_actions                = var.ok_actions
  insufficient_data_actions = var.insufficient_data_actions

  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  threshold           = var.threshold
  unit                = var.unit

  datapoints_to_alarm = var.datapoints_to_alarm
  treat_missing_data  = var.treat_missing_data

  metric_name        = var.metric_name
  namespace          = var.namespace
  period             = var.period
  statistic          = var.statistic
  extended_statistic = var.extended_statistic

  dimensions = var.dimensions

  tags = var.tags
}
