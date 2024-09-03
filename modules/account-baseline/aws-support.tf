module "aws_support" {
  count = var.create_aws_support_role ? 1 : 0

  source    = "./modules/aws-support"
  role_name = "${var.resource_name_prefix}-support"
  tags      = var.tags
}
