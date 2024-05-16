data "aws_caller_identity" "this" {
}

output "account_id" {
  value = local.account_id
}

resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.this.json
  tags               = var.tags
}

data "aws_iam_policy_document" "this" {
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "this" {
  name = "${var.policy_name}"
  role = aws_iam_role.this.id
  policy = jsonencode({
    Statement = [{
      Sid    = "AllowWriteToCloudwatchLogs"
      Effect = "Allow"
      Action = [
        "logs:PutLogEvents",
        "logs:CreateLogStream"
      ]
      Resource = "arn:aws:logs:eu-west-2:${local.account_id}:log-group:/aws/lambda/notify_slack:*"
      Version  = "2012-10-17"
    }]
  })
}

data "aws_iam_policy_document" "topic_assume_policy" {
  statement {
    sid    = "__default_statement_ID"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "SNS:GetTopicAttributes",
      "SNS:SetTopicAttributes",
      "SNS:AddPermission",
      "SNS:RemovePermission",
      "SNS:DeleteTopic",
      "SNS:Subscribe",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Publish",
      "SNS:Receive"
    ]
    resources = ["arn:aws:sns:eu-west-2:${local.account_id}:alarms-topic-slack"]
  }
}

resource "aws_sns_topic" "alarm-topic-slack" {
  name   = "alarms-topic-slack"
  tags   = var.tags
  policy = data.aws_iam_policy_document.topic_assume_policy.json
}

module "notify_slack" {
  source  = "terraform-aws-modules/notify-slack/aws"
  version = "~> 6.4"

  sns_topic_name   = "alarms-topic-slack"
  create_sns_topic = false

  lambda_role = "arn:aws:iam::${local.account_id}:role/${var.role_name}"

  slack_webhook_url = var.slack_webhook_url
  slack_channel     = var.slack_channel
  slack_username    = var.slack_username
  tags              = var.tags
}

locals {
  account_id = data.aws_caller_identity.this.account_id
}