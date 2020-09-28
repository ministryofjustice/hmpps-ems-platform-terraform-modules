data "aws_iam_policy_document" "lambda" {
  statement {
    sid       = "AWSLambdaDescribeSearchTransits"
    effect    = "Allow"
    actions   = ["ec2:DescribeTransitGateways", "ec2:DescribeTransitGatewayRouteTables", "ec2:SearchTransitGatewayRoutes"]
    resources = ["*"]
  }
  statement {
    sid       = "AWSLambdaPutMetrics"
    effect    = "Allow"
    actions   = ["cloudwatch:PutMetricData"]
    resources = ["*"]
  }
}


data "aws_iam_policy_document" "assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}


resource "aws_iam_policy" "lambda" {
  name   = local.lambda_iam_policy_name
  path   = "/"
  policy = data.aws_iam_policy_document.lambda.json
}


resource "aws_iam_role" "lambda" {
  name               = local.lambda_iam_role_name
  assume_role_policy = data.aws_iam_policy_document.assume.json
  tags               = var.tags
}


resource "aws_iam_role_policy_attachment" "lambda" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda.arn
}


resource "aws_iam_role_policy_attachment" "lambda_default_execution_role" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
