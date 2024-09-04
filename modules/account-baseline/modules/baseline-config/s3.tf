module "config_s3_bucket" {
  source = "../../../standard-s3-bucket"

  name = local.config_s3_bucket_name
  tags = var.tags
}
