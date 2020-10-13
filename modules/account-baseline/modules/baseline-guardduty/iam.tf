data "aws_iam_policy_document" "cloudwatch" {
  statement {
    sid       = "AWSCloudTrail"
    effect    = "Allow"
    actions   = ["logs:*"]
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${aws_cloudwatch_log_group.cloudwatch.name}*"]
  }
}


data "aws_iam_policy_document" "assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}


resource "aws_iam_policy" "cloudwatch" {
  name   = local.cloudwatch_iam_policy_name
  policy = data.aws_iam_policy_document.cloudwatch.json
}


resource "aws_iam_role" "cloudwatch" {
  name               = local.cloudwatch_iam_role_name
  assume_role_policy = data.aws_iam_policy_document.assume.json
  tags               = var.tags
}


resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.cloudwatch.name
  policy_arn = aws_iam_policy.cloudwatch.arn
}