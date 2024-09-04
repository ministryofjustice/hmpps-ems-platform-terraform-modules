module "ebs" {
  count = var.enable_ebs_encryption_by_default ? 1 : 0

  source = "./modules/ebs"
}
