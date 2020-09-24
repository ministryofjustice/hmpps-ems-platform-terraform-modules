module default_policies {
  source = "./modules/default-policies"
}


data "aws_iam_policy" "DBAAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}


data "aws_iam_policy" "ReadOnlyAccess" {
  arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}


data "aws_iam_policy" "AdministratorAccess" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


locals {
  user_malicious_activity_deny_policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/hmpps-user-malicious-activity-deny-policy"
}
