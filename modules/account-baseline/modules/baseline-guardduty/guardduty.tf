resource "aws_guardduty_detector" "this" {
  enable = true
  tags   = var.tags
}
