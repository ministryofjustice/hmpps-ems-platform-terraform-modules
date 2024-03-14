locals {
  # Enable the decryption of S3 objects
  decrypt_logs = {
    effect = "Allow"

    actions = [
      "kms:Decrypt*",
      "kms:Describe*",
    ]

    resources = var.s3_access.kms_keys
  }

  download_s3_objects = {
    DownloadObjects = {
      effect = "Allow"

      actions = [
        "s3:GetObject",
        "s3:GetObjectVersion",
      ]

      resources = formatlist("%s/*", var.s3_access.bucket_arns)
    }
  }

  ec2_asset_collection = {
    EC2AssetCollection = {
      effect = "Allow"

      actions = [
        "ec2:DescribeInstances",
        "ec2:DescribeRegions",
        "ec2:DescribeSubnets",
        "ec2:DescribeVpcs",
      ]

      resources = [
        "*"
      ]
    }
  }

  guardduty_access = {
    GuardDutyAPIAccess = {
      effect = "Allow"

      actions = [
        "guardduty:ListDetectors",
        "guardduty:ListFindings",
        "guardduty:GetFindings",
      ]

      resources = [
        "*"
      ]
    }
  }

  list_s3_objects = {
    ListObjects = {
      effect = "Allow"

      actions = [
        "s3:ListBucket",
        "s3:GetBucketLocation",
      ]

      resources = var.s3_access.bucket_arns
    }
  }

  process_sqs_messages = {
    ProcessQueueMessages = {
      effect = "Allow"

      actions = [
        "sqs:DeleteMessage",
        "sqs:GetQueueUrl",
        "sqs:GetQueueAttributes",
        "sqs:ReceiveMessage",
      ]

      resources = var.sqs_access.queue_arns
    }
  }

  security_hub_api = {
    ProcessSecurityHubFindings = {
      effect = "Allow"

      actions = [
        "securityhub:BatchUpdateFindings",
        "securityhub:DescribeProducts",
        "securityhub:DescribeStandards",
        "securityhub:DescribeStandardsControls",
        "securityhub:GetEnabledStandards",
        "securityhub:GetFindings",
        "securityhub:GetInsights",
        "securityhub:GetInsightResults",
      ]

      resources = [
        "*"
      ]
    }
  }

  policy_statements = merge(
    [local.download_s3_objects, {}][var.s3_access.enabled ? 0 : 1],
    [local.ec2_asset_collection, {}][var.enable_ec2_asset_collection ? 0 : 1],
    [local.guardduty_access, {}][var.enable_guardduty_access ? 0 : 1],
    [local.list_s3_objects, {}][var.s3_access.enabled ? 0 : 1],
    [local.process_sqs_messages, {}][var.sqs_access.enabled ? 0 : 1],
    [local.security_hub_api, {}][var.enable_security_hub_access ? 0 : 1],
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
      sid       = statement.key
      effect    = statement.value["effect"]
      actions   = statement.value["actions"]
      resources = statement.value["resources"]
    }
  }
}
