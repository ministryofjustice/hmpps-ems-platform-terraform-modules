module "securityhub_standards" {
  count = var.enable_securityhub_standards ? 1 : 0

  source = "./modules/securityhub-standards"
}
