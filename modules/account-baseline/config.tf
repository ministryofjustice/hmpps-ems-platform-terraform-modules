module "baseline_config" {
  count = var.enable_aws_config ? 1 : 0

  source               = "./modules/config"
  resource_name_prefix = var.resource_name_prefix
  tags                 = var.tags
}
