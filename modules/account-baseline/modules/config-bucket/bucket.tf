module "bucket" {
  source = "../../../standard-s3-bucket"

  name   = local.bucket_name
  policy = data.aws_iam_policy_document.bucket_policy.json

  tags = var.tags
}
