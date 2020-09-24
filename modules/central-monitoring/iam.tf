# https://grafana.com/docs/grafana/latest/features/datasources/cloudwatch/#iam-roles
data "aws_iam_policy_document" "cloudwatch" {
  statement {
    sid       = "AllowReadingMetricsFromCloudWatch"
    effect    = "Allow"
    actions   = ["cloudwatch:DescribeAlarmsForMetric", "cloudwatch:DescribeAlarmHistory", "cloudwatch:DescribeAlarms", "cloudwatch:ListMetrics", "cloudwatch:GetMetricStatistics", "cloudwatch:GetMetricData"]
    resources = ["*"]
  }
  statement {
    sid    = "AllowReadingLogsFromCloudWatch"
    effect = "Allow"
    actions = [
      "logs:DescribeLogGroups",
      "logs:GetLogGroupFields",
      "logs:StartQuery",
      "logs:StopQuery",
      "logs:GetQueryResults",
      "logs:GetLogEvents"
    ]
    resources = ["*"]
  }
  statement {
    sid       = "AllowReadingResourcesForTags"
    effect    = "Allow"
    actions   = ["tag:GetResources"]
    resources = ["*"]
  }
}


data "aws_iam_policy_document" "assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }
}


resource "aws_iam_policy" "cloudwatch" {
  name   = local.cloudwatch_iam_policy_name
  policy = data.aws_iam_policy_document.cloudwatch.json
}


# resource "aws_iam_role" "cloudwatch" {
#   name               = local.cloudwatch_iam_role_name
#   assume_role_policy = data.aws_iam_policy_document.assume.json
#   tags               = var.tags
# }


# resource "aws_iam_role_policy_attachment" "cloudwatch" {
#   role       = aws_iam_role.cloudwatch.name
#   policy_arn = aws_iam_policy.cloudwatch.arn
# }


resource "aws_iam_user" "central_monitoring" {
  name = local.central_monitoring_iam_username
  tags = var.tags
}


resource "aws_iam_user_policy_attachment" "central_monitoring_cloudwatch" {
  user       = aws_iam_user.central_monitoring.name
  policy_arn = aws_iam_policy.cloudwatch.arn
}
