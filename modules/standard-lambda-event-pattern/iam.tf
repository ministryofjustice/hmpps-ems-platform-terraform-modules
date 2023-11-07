data "aws_iam_policy_document" "assume" {
  statement {
    sid    = "AllowLambdaAssumeRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com"
      ]
    }
  }
}


data "aws_iam_policy_document" "lambda_policy" {

  source_policy_documents = [
    var.iam_policy,
  ]

  statement {
    sid    = "AllowCloudwatchLogs"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }
}

resource "aws_iam_role" "this" {
  name               = local.role_name
  assume_role_policy = data.aws_iam_policy_document.assume.json
}


resource "aws_iam_role_policy" "this" {
  name   = local.role_policy_name
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.lambda_policy.json
}
