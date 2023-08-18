data "aws_iam_policy_document" "billing-deny-write-policy" {
  statement {
    actions = [
      "account:*",
      "billing:*",
      "payments:*",
      "budgets:ModifyBudget",
      "ce:CreateCostCategoryDefinition",
      "ce:DeleteCostCategoryDefinition",
      "ce:UpdateCostCategoryDefinition"
    ]
    effect = "Deny"
    resources = [
      "*"
    ]
  }
}


resource "aws_iam_policy" "billing-deny-write-policy" {
  name   = "hmpps-billing-deny-write-group-policy"
  policy = data.aws_iam_policy_document.billing-deny-write-policy.json
}
