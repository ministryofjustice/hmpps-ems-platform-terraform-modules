variable "alarm_widgets" {
  default     = []
  description = "List of CloudWatch Alarm ARNs to display at the top of the deashboard"
  type        = list(string)
}

variable "column_count" {
  default     = 2
  description = "The number of columns in the dashboard. Widgets are sized to fill the entire column."
  type        = number
}

variable "metric_widgets" {
  default     = []
  description = "List of CloudWatch Metric widgets to display."
  type = list(object({
    name      = string
    metrics   = list(list(any))
    view      = optional(string, "timeSeries")
    sparkline = optional(bool, false)
    stack     = optional(bool, false)
    start     = optional(string, "")
    end       = optional(string, "")
    stat      = optional(string, "Average")
    period    = optional(number, 300)
  }))
}

variable "name" {
  description = "The name of the dashboard."
  type        = string
}

variable "widget_height" {
  default     = 6
  description = "The height of all widgets in the dashboard"
  type        = number
}
