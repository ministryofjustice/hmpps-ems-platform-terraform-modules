output "cloudtrail_kms_key_arn" {
  value = module.baseline_cloudtrail.kms_key_arn
}

output "cloudtrail_kms_key_alias" {
  value = module.baseline_cloudtrail.kms_key_alias
}
