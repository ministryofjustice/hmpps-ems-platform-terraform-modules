output "sns_topic_arn" {
  description = "The ARN of the SNS topic to send alerts to."
  value       = try(aws_sns_topic.this[0].arn, null)
}
