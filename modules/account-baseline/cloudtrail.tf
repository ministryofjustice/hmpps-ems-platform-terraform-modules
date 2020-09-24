module "baseline_cloudtrail" {
  source                             = "./modules/baseline-cloudtrail"
  resource_name_prefix               = var.resource_name_prefix
  sl_firehose_destination_cloudtrail = var.sl_firehose_destination_cloudtrail
  tags                               = var.tags
}
