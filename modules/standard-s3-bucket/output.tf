output "id" {
  value       = aws_s3_bucket.this.id
  description = "The id of the bucket."
}

output "arn" {
  value       = aws_s3_bucket.this.arn
  description = "The arn of the bucket."
}
