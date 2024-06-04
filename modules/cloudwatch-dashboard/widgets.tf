locals {
  max_width    = 24 // CloudWatch dashboards use a 24 column grid
  widget_width = local.max_width / var.column_count

  metric_widgets = [
    for index, alarm in values(var.metric_widgets) : {
      type   = "metric"
      x      = (index % var.column_count) * local.widget_width
      y      = local.alarm_widget.y + floor(index / var.column_count) * var.widget_height
      width  = local.widget_width
      height = var.widget_height

      properties = {
        metrics = [
          concat(
            [
              alarm.namespace,
              alarm.metric_name
            ],
            flatten([for k, v in alarm.dimensions : [k, v]])
          )
        ]
        period = alarm.period
        stat   = alarm.statistic
        region = data.aws_region.current.name
        title  = alarm.name
      }
    }
  ]

  alarm_widget = {
    type   = "alarm",
    x      = 0,
    y      = 0,
    width  = 24,
    height = 4,
    properties = {
      title = "Alarms",
      alarms = [
        for alarm in module.alarms : alarm.cloudwatch_metric_alarm_arn
      ]
    }
  }

  widgets = concat(
    [local.alarm_widget],
    local.metric_widgets
  )
}
