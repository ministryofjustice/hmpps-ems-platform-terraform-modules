data "aws_iam_policy_document" "vpc_flow_logs_policy" {

  statement {
    sid    = "AllowLogGroupManagement"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    resources = [
      "*"
    ]
  }
}


data "aws_iam_policy_document" "vpc_flow_logs_assume_role" {

  statement {
    sid    = "AllowVPCFlogLogsAssumeRole"
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "vpc-flow-logs.amazonaws.com"
      ]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}


resource "aws_iam_role" "this" {
  name               = local.cloudwatch_role_name
  assume_role_policy = data.aws_iam_policy_document.vpc_flow_logs_assume_role.json
}


resource "aws_iam_role_policy" "this" {
  name   = local.cloudwatch_role_policy_name
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.vpc_flow_logs_policy.json
}
