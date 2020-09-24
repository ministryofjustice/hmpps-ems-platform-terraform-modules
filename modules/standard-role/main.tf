data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.iam_account_id}:root"
      ]
    }

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"

      values = [
        "true"
      ]
    }
  }
}


resource "aws_iam_role" "this" {
  name               = var.role_name
  description        = var.role_description
  assume_role_policy = data.aws_iam_policy_document.this.json
  path               = var.path
  tags               = var.tags
}


# --- Default policy attachments
resource "aws_iam_role_policy_attachment" "default_policy_attachment" {
  for_each   = toset(local.default_policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = each.value
}


# --- Handle extra policies provided by input
resource "aws_iam_role_policy_attachment" "input_policy_attachment" {
  for_each   = toset(var.policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = each.value
}
