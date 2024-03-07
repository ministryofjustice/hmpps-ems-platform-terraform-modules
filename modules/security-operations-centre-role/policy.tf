locals {
  download_s3_objects = {
    sid    = "DownloadObjects"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",

    ]

    resources = formatlist("%s/*", var.s3_access.bucket_arns)
  }

  list_s3_objects = {
    sid    = "ListObjects"
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = var.s3_access.bucket_arns
  }

  process_sqs_messages = {
    sid    = "ProcessQueueMessages"
    effect = "Allow"

    actions = [
      "sqs:DeleteMessage",
      "sqs:ReceiveMessage",
    ]

    resources = var.sqs_access.queue_arns
  }

  policy_statements = merge(
    var.s3_access.enabled ? local.download_s3_objects : {},
    var.s3_access.enabled ? local.list_s3_objects : {},
    var.sqs_access.enabled ? local.process_sqs_messages : {}
  )
}

resource "aws_iam_policy" "this" {
  name        = "${var.name_prefix}-security-operations-centre-policy"
  path        = "/"
  description = "Gives the security operations centre role the permissions to process security events"
  policy      = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "this" {
  dynamic "statement" {
    for_each = local.policy_statements
    content {
      sid       = statement.value["sid"]
      effect    = statement.value["effect"]
      actions   = statement.value["actions"]
      resources = statement.value["resources"]
    }
  }
}
