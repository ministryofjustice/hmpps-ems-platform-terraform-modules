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


module "blackhole_monitor" {
  source               = "../standard-lambda"
  resource_name_prefix = local.resource_name_prefix
  service_name         = "blackhole-monitor"
  source_dir           = "${path.module}/src"
  output_path          = "${path.module}/files/blackhole-monitor.zip"
  iam_policy           = data.aws_iam_policy_document.lambda_policy.json
  tags                 = local.tags
}
