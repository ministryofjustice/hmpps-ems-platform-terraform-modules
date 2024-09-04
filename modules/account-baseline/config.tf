resource "aws_iam_service_linked_role" "config_service_role" {
  aws_service_name = "config.amazonaws.com"
}

module "config_bucket" {
  count  = var.enable_aws_config ? 1 : 0
  source = "./modules/config-bucket"

  resource_name_prefix = var.resource_name_prefix
  tags                 = var.tags
}

# Enable config in all regions that SecurityHub is enabled
module "config_eu_west_1" {
  count  = var.enable_aws_config ? 1 : 0

  source = "./modules/config"
  
  providers = {
    aws = aws.eu_west_1
  }

  config_bucket_name   = module.config_bucket.bucket_id
  config_service_role  = aws_iam_service_linked_role.config_service_role.arn
  resource_name_prefix = var.resource_name_prefix
  tags                 = var.tags
}

module "config_eu_west_2" {
  count  = var.enable_aws_config ? 1 : 0

  source = "./modules/config"
  
  providers = {
    aws = aws.eu_west_2
  }

  config_bucket_name   = module.config_bucket.bucket_id
  config_service_role  = aws_iam_service_linked_role.config_service_role.arn
  resource_name_prefix = var.resource_name_prefix
  tags                 = var.tags
}

module "config_eu_west_3" {
  count  = var.enable_aws_config ? 1 : 0

  source = "./modules/config"
  
  providers = {
    aws = aws.eu_west_3
  }

  config_bucket_name   = module.config_bucket.bucket_id
  config_service_role  = aws_iam_service_linked_role.config_service_role.arn
  resource_name_prefix = var.resource_name_prefix
  tags                 = var.tags
}

module "config_eu_central_1" {
  count  = var.enable_aws_config ? 1 : 0

  source = "./modules/config"
  
  providers = {
    aws = aws.eu_central_1
  }

  config_bucket_name   = module.config_bucket.bucket_id
  config_service_role  = aws_iam_service_linked_role.config_service_role.arn
  resource_name_prefix = var.resource_name_prefix
  tags                 = var.tags
}

module "config_us_east_1" {
  count  = var.enable_aws_config ? 1 : 0

  source = "./modules/config"
  
  providers = {
    aws = aws.us_east_1
  }

  config_bucket_name   = module.config_bucket.bucket_id
  config_service_role  = aws_iam_service_linked_role.config_service_role.arn
  resource_name_prefix = var.resource_name_prefix
  tags                 = var.tags
}
