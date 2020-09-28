data "archive_file" "source" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/files/blackhole-monitor.zip"
}

# data "archive_file" "layer" {
#   type        = "zip"
#   source_dir  = "${path.module}/layers"
#   output_path = "${path.module}/files/blackhole-monitor-layer.zip"
# }

# resource "aws_lambda_layer_version" "this" {
#   filename   = data.archive_file.layer.output_path
#   # layer_name = local.lambda_function_layer_name

#   source_code_hash    = filebase64sha256(data.archive_file.layer.output_path)
#   compatible_runtimes = ["${local.lambda_function_runtime}"]
# }

resource "aws_lambda_function" "this" {
  filename      = data.archive_file.source.output_path
  function_name = local.lambda_function_name
  role          = aws_iam_role.lambda.arn
  handler       = "monitor.lambda_handler"
  # layers = [
  #   aws_lambda_layer_version.this.arn
  # ]

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
