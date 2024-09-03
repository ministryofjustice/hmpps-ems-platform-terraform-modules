module "ebs" {
  count = var.create_aws_support_role ? 1 : 0

  source    = "./modules/aws-support"
  role_name = "${resource_name_prefix}-support"
  tags      = var.tags
}
