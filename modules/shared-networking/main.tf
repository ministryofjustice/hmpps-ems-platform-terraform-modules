module vpc_flow_logs {
  source = "./modules/vpc-flow-logs"

  resource_name_prefix = var.resource_name_prefix
  vpc_name = var.vpc_name
  cloudwatch_destination_arn = var.cloudwatch_destination_arn
  tags = var.tags
}
