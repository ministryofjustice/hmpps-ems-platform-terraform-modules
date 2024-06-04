variable "column_count" {
  default     = 2
  description = "The number of columns in the dashboard. Widgets are sized to fill the entire column."
  type        = number
}

variable "metric_widgets" {
  default     = {}
  description = "List of CloudWatch Metric widgets to display."
  type = map(object({

    name = string

    metrics   = list(list(string))
    view      = optional(string, "timeSeries")
    sparkline = optional(bool, false)
    stack     = optional(bool, false)
    start     = optional(string, "")
    end       = optional(string, "")
    stat      = optional(string, "")
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
