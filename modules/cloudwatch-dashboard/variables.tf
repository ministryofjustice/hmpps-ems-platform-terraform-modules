variable "column_count" {
  default     = 2
  description = "The number of columns in the dashboard. Widgets are sized to fill the entire column."
  type        = number
}

variable "metric_widgets" {
  default     = {}
  description = "List of CloudWatch Metric widgets to display."
  type = map(object({
   
    name        = string
    properties = map(any)
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
