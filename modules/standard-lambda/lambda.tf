locals {
  has_environment_variables = length(var.environment_variables) > 0
}

data "archive_file" "source" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = var.output_path
}


resource "aws_lambda_function" "this" {
  filename      = data.archive_file.source.output_path
  function_name = local.lambda_name
  role          = aws_iam_role.this.arn
  handler       = var.handler

  source_code_hash = filebase64sha256(data.archive_file.source.output_path)

  runtime = var.runtime
  timeout = var.timeout

  dynamic "environment" {
    for_each = local.has_environment_variables ? [1] : []
    content {
      variables = var.environment_variables
    }
  }

  tags = var.tags
}
