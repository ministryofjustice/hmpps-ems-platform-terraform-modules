module "aws_support" {
  count = var.provision_aws_support_role ? 1 : 0

  source    = "./modules/aws-support"
  role_name = "${var.resource_name_prefix}-support"
  tags      = var.tags
}
