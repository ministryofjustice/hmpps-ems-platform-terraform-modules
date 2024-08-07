output "sns_topic_arn" {
  description = "The ARN of the SNS topic to send alerts to."
  value       = aws_sns_topic.this.arn
}
