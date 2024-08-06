module "alarms" {
  for_each = var.alarms

  source = "../cloudwatch-alarm"

  alarm_name  = each.value.name
  runbook_url = each.value.runbook

  comparison_operator = each.value.comparison_operator
  evaluation_periods  = each.value.evaluation_periods
  threshold           = each.value.threshold

  metric_name         = each.value.metric_name
  namespace           = each.value.namespace
  period              = each.value.period
  statistic           = each.value.statistic
  datapoints_to_alarm = each.value.datapoints_to_alarm
  treat_missing_data  = each.value.treat_missing_data

  dimensions = each.value.dimensions

  alarm_actions             = each.value.actions
  insufficient_data_actions = each.value.actions
  ok_actions                = each.value.actions

  tags = var.tags
}
