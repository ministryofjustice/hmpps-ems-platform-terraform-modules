output "externalid" {
  description = "The externalid to be provided by the security operations centre principal when assuming this role."
  value       = random_string.externalid.result
}

output "role" {
  description = "The attributes of the role created by this module."
  value       = aws_iam_role.this
}

output "policy" {
  description = "The attributes of the policy created by this module."
  value       = aws_iam_policy.this
}
