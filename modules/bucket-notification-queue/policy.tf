data "aws_iam_policy_document" "this" {
  statement {
    sid = "AllowBucketToPublishEvents"

    actions = [
      "sqs:SendMessage"
    ]

    principals {
      type = "Service"

      identifiers = [
        "s3.amazonaws.com"
      ]
    }

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values = [
        var.publishing_bucket_arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values = [
        data.aws_caller_identity.current.account_id
      ]
    }

    resources = [
      aws_sqs_queue.this.arn
    ]
  }

  statement {
    sid = "AllowTopicToPublishEvents"

    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    }

    actions = [
      "sqs:SendMessage"
    ]

    resources = [
      aws_sqs_queue.this.arn
    ]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [
        var.publishing_topic_arn
      ]
    }
  }

  statement {
    sid = "AllowProcessorToReceiveDeleteEvents"

    actions = [
      "sqs:DeleteMessage",
      "sqs:ReceiveMessage",
      "sqs:GetQueueUrl",
    ]

    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        var.processing_role_arn
      ]
    }

    resources = [
      aws_sqs_queue.this.arn
    ]
  }
}
