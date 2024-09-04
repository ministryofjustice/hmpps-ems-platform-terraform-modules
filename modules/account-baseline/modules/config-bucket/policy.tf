data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid    = "AWSConfigBucketPermissionsCheck"
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = [
        "config.amazonaws.com"
      ]
    }

    actions = [
      "s3:GetBucketAcl"
    ]

    resources = [
      "arn:aws:s3:::${local.bucket_name}"
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"
      values = [
        data.aws_caller_identity.current.account_id
      ]
    }
  }

  statement {
    sid    = "AWSConfigBucketExistenceCheck"
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = [
        "config.amazonaws.com"
      ]
    }

    actions = [
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::${local.bucket_name}"
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"
      values = [
        data.aws_caller_identity.current.account_id
      ]
    }
  }

  statement {
    sid    = "AWSConfigBucketDelivery"
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = [
        "config.amazonaws.com"
      ]
    }

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "arn:aws:s3:::${local.bucket_name}/AWSLogs/${data.aws_caller_identity.current.account_id}/Config/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"
      values = [
        data.aws_caller_identity.current.account_id
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values = [
        "bucket-owner-full-control"
      ]
    }
  }
}
