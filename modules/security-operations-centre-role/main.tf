resource "aws_iam_role" "this" {
  name               = "${var.name_prefix}-security-operations-centre-role"
  description        = "Delegate access to security operations centre to process security events."
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags               = var.tags
}

// ExternalId is visible in the console, no point in making it secret
resource "random_string" "externalid" {
  length  = 16
  special = true
  override_special = "+=,.@:/-"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "AWS"

      identifiers = [
        var.security_operations_centre_aws_principal
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values = [
        random_string.externalid.result
      ]
    }
  }
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
