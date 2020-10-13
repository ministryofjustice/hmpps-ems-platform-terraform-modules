module "baseline_guardduty" {
  source                             = "./modules/baseline-guardduty"
  resource_name_prefix               = var.resource_name_prefix
  tags                               = var.tags
}
