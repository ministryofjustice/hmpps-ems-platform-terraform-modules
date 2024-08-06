variable "alarms" {
  description = "A mapping of cloudwatch alarms to create."
  type = map(
    object({
      name    = string
      runbook = string

      comparison_operator = string
      evaluation_periods  = number
      threshold           = number

      metric_name         = string
      namespace           = string
      period              = number
      statistic           = string
      datapoints_to_alarm = number
      treat_missing_data  = string

      dimensions = map(string)

      actions = list(string)
    })
  )
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}