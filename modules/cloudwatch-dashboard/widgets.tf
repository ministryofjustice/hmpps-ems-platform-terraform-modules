locals {
  max_width    = 24 // CloudWatch dashboards use a 24 column grid
  widget_width = local.max_width / var.column_count

  metric_widgets = [
    for index, alarm in var.metric_widgets : {
      type   = "metric"
      x      = (index % var.column_count) * local.widget_width
      y      = local.alarm_widget.y + floor(index / var.column_count) * var.widget_height
      width  = local.widget_width
      height = var.widget_height

      properties = {
        metrics   = alarm.metrics
        period    = alarm.period
        stat      = alarm.stat
        region    = data.aws_region.current.name
        title     = alarm.name
        view      = alarm.view
        stack     = alarm.stack
        start     = alarm.start
        end       = alarm.end
        sparkline = alarm.sparkline
      }
    }
  ]

  alarms_widget = {
    type   = "alarm",
    x      = 0,
    y      = 0,
    width  = 24,
    height = 4,
    properties = {
      title  = "Alarms",
      alarms = var.alarm_widgets
    }
  }

  widgets = concat(
    length(var.alarm_widgets) > 0 ? [local.alarms_widget] : [],
    local.metric_widgets
  )
}
