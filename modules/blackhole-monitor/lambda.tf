data "archive_file" "source" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/files/blackhole-monitor.zip"
}


resource "aws_lambda_function" "this" {
  filename      = data.archive_file.source.output_path
  function_name = local.lambda_function_name
  role          = aws_iam_role.lambda.arn
  handler       = "monitor.lambda_handler"

  source_code_hash = filebase64sha256(data.archive_file.source.output_path)

  runtime = local.lambda_function_runtime
  timeout = local.lambda_function_timeout

  tags = var.tags
}

resource "aws_lambda_permission" "this" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this.arn
}
