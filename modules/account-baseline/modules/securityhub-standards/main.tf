data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# Enable Standard: AWS Foundational Security Best Practices
resource "aws_securityhub_standards_subscription" "aws_foundational" {
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/aws-foundational-security-best-practices/v/1.0.0"
}

# Enable Standard: CIS AWS Foundations
resource "aws_securityhub_standards_subscription" "cis" {
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/cis-aws-foundations-benchmark/v/3.0.0"
}

# Disable IAM.6 - AWS Foundational Security Best Practices v1.0.0
resource "aws_securityhub_standards_control" "default_aws_foundational_security_best_practices_hardware_mfa" {
  standards_control_arn = "arn:aws:securityhub:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:control/aws-foundational-security-best-practices/v/1.0.0/IAM.6"
  control_status        = "DISABLED"
  disabled_reason       = "Root user access is controlled by the hosting team."
  depends_on            = [
    aws_securityhub_standards_subscription.aws_foundational
  ]
}

# Disable IAM.6 - CIS AWS Foundations Benchmark v3.0.0
resource "aws_securityhub_standards_control" "default_cis_aws_foundations_hardware_mfa" {
  standards_control_arn = "arn:aws:securityhub:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:control/cis-aws-foundations-benchmark/v/1.2.0/1.14"
  control_status        = "DISABLED"
  disabled_reason       = "Root user access is controlled by the hosting team."
  depends_on            = [
    aws_securityhub_standards_subscription.cis
  ]
}
