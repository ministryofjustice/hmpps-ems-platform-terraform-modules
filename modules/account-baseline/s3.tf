module "s3" {
  count = var.enable_s3_account_public_access_block ? 1 : 0

  source = "./modules/s3"
}
