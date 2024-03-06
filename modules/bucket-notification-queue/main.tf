data "aws_caller_identity" "current" {}

resource "aws_sqs_queue" "this" {
  name = var.queue_name
  tags = var.tags
}

resource "aws_sqs_queue_policy" "this" {
  queue_url = aws_sqs_queue.this.id
  policy    = data.aws_iam_policy_document.this.json
}
