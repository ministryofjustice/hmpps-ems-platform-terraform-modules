module "DBAdminRole" {
  source           = "../standard-role"
  role_name        = "DBAdminRole"
  role_description = "DBA level permissions"
  iam_account_id   = var.iam_account_id
  policy_arns = [
    data.aws_iam_policy.DBAAccess.arn,
    local.user_malicious_activity_deny_policy_arn
  ]
  tags = var.tags
}


module "InfraAdminRole" {
  source           = "../standard-role"
  role_name        = "InfraAdminRole"
  role_description = "Admin level permissions with exclusions"
  iam_account_id   = var.iam_account_id
  policy_arns = [
    data.aws_iam_policy.AdministratorAccess.arn,
    local.user_malicious_activity_deny_policy_arn
  ]
  tags = var.tags
}


module "PenTestRole" {
  source           = "../standard-role"
  role_name        = "PenTestRole"
  role_description = "PenTest permissions"
  iam_account_id   = var.iam_account_id
  policy_arns = [
    data.aws_iam_policy.AdministratorAccess.arn,
    local.user_malicious_activity_deny_policy_arn
  ]
  tags = var.tags
}


module "ReadOnlyRole" {
  source           = "../standard-role"
  role_name        = "ReadOnlyRole"
  role_description = "ReadOnly permissions"
  iam_account_id   = var.iam_account_id
  policy_arns = [
    data.aws_iam_policy.ReadOnlyAccess.arn,
    local.user_malicious_activity_deny_policy_arn
  ]
  tags = var.tags
}


module "SupportRole" {
  source           = "../standard-role"
  role_name        = "SupportRole"
  role_description = "Support permissions"
  iam_account_id   = var.iam_account_id
  policy_arns = [
    data.aws_iam_policy.ReadOnlyAccess.arn,
    local.user_malicious_activity_deny_policy_arn
  ]
  tags = var.tags
}


module "TestRole" {
  source           = "../standard-role"
  role_name        = "TestRole"
  role_description = "Test permissions"
  iam_account_id   = var.iam_account_id
  policy_arns = [
    data.aws_iam_policy.ReadOnlyAccess.arn,
    local.user_malicious_activity_deny_policy_arn
  ]
  tags = var.tags
}
