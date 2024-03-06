output "arn" {
  value       = aws_sqs_queue.this.arn
  description = "The arn of the queue created by this module."
}
