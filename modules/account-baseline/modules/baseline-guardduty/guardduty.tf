resource "aws_guardduty_detector" "this" {
  count                        = var.provision_guardduty_detector ? 1 : 0
  enable                       = var.enable_collector
  finding_publishing_frequency = var.publishing_frequency
  tags                         = var.tags
}
