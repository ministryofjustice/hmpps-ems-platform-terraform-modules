module "baseline_cloudtrail" {
  source                             = "./modules/baseline-cloudtrail"
  resource_name_prefix               = var.resource_name_prefix
  tags                               = var.tags
}
