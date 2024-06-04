resource "aws_cloudwatch_dashboard" "this" {
  dashboard_name = var.name

  dashboard_body = jsonencode({
    widgets = local.widgets
  })
}