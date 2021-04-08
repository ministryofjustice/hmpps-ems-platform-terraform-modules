data "aws_iam_policy_document" "cloudwatch" {
  statement {
    sid       = "AWSCloudTrailCreateLogStream"
    effect    = "Allow"
    actions   = ["logs:CreateLogStream"]
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${aws_cloudwatch_log_group.cloudwatch.name}:log-stream:${aws_cloudwatch_log_stream.cloudwatch.name}*"]
  }

  statement {
    sid       = "AWSCloudTrailPutLogEvents"
    effect    = "Allow"
    actions   = ["logs:PutLogEvents"]
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${aws_cloudwatch_log_group.cloudwatch.name}:log-stream:${aws_cloudwatch_log_stream.cloudwatch.name}*"]
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
  path   = "/service-role/"
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


resource "aws_cloudwatch_log_group" "cloudwatch" {
  name       = local.cloudwatch_log_group_name
  kms_key_id = aws_kms_key.this.arn
  tags       = var.tags
}


resource "aws_cloudwatch_log_stream" "cloudwatch" {
  name           = "${data.aws_caller_identity.current.account_id}_CloudTrail_${data.aws_region.current.name}"
  log_group_name = aws_cloudwatch_log_group.cloudwatch.name
}
