module "baseline_guardduty" {
  source                            = "./modules/baseline-guardduty"
  resource_name_prefix              = var.resource_name_prefix
  provision_guardduty_detector      = var.provision_guardduty_detector
  sl_firehose_destination_guardduty = var.sl_firehose_destination_guardduty
  tags                              = var.tags
}
