output "queue" {
  value       = aws_sqs_queue.this
  description = "The attributes of the queue created by this module."
}
