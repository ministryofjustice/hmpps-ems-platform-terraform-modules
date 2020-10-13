resource "aws_guardduty_detector" "this" {
  enable                       = var.enable_collector
  finding_publishing_frequency = var.publishing_frequency
  tags                         = var.tags
}
