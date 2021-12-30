module "baseline_config" {
  source               = "./modules/baseline-config"
  resource_name_prefix = var.resource_name_prefix
  tags                 = var.tags
}
