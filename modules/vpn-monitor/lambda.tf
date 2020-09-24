resource "aws_iam_role" "this" {
  name = local.role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}


resource "aws_iam_role_policy" "this" {
  name = local.role_policy_name
  role = aws_iam_role.this.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Action": "EC2:*",
        "Effect": "Allow",
        "Resource": "*"
    },
    {
        "Action": "logs:*",
        "Effect": "Allow",
        "Resource": "*"
    },
    {
        "Action": "sns:*",
        "Effect": "Allow",
        "Resource": "*"
    },
    {
        "Action": "kms:*",
        "Effect": "Allow",
        "Resource": "*"
    },
    {
        "Action": [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:DescribeTable",
          "dynamodb:DeleteItem"
        ],
        "Effect": "Allow",
        "Resource": [
          "${aws_dynamodb_table.this.arn}"
        ]
    }
  ]

}
POLICY
}


# --- Trigger the lambda every 5 minutes
resource "aws_cloudwatch_event_rule" "this" {
  name                = local.cloudwatch_event_rule_name
  description         = "A rule that triggers the vpn-monitor lambda on a configurable schedule"
  schedule_expression = "rate(5 minutes)"
  tags                = var.tags
}


resource "aws_cloudwatch_event_target" "this" {
  target_id = local.cloudwatch_event_target_id
  rule      = aws_cloudwatch_event_rule.this.name
  arn       = aws_lambda_function.this.arn
}


resource "aws_lambda_permission" "this" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this.arn
}


# --- Deploy lambda
data "archive_file" "source" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/files/vpn-monitor.zip"
}

data "archive_file" "layer" {
  type        = "zip"
  source_dir  = "${path.module}/layers"
  output_path = "${path.module}/files/vpn-monitor-layer.zip"
}

resource "aws_lambda_layer_version" "this" {
  filename   = data.archive_file.layer.output_path
  layer_name = "vpn-monitor-modules"

  source_code_hash    = filebase64sha256(data.archive_file.layer.output_path)
  compatible_runtimes = ["python3.8"]
}

resource "aws_lambda_function" "this" {
  filename      = data.archive_file.source.output_path
  function_name = local.lambda_name
  role          = aws_iam_role.this.arn
  handler       = "monitor.lambda_handler"
  layers = [
    aws_lambda_layer_version.this.arn
  ]


  source_code_hash = filebase64sha256(data.archive_file.source.output_path)

  runtime = "python3.8"
  timeout = 600

  environment {
    variables = {
      sns_email_topic_name = aws_sns_topic.this.name
      sns_slack_topic_name = "alarms-topic-slack"
      state_table_name     = aws_dynamodb_table.this.name
      enable_mock_response = var.enable_mock_response
    }
  }

  tags = var.tags
}
