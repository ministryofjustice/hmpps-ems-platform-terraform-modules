data "aws_iam_policy_document" "user-malicious-activity-deny-policy" {
  statement {
    actions = [
      "cloudtrail:DeleteTrail",
      "cloudtrail:StopLogging",
      "cloudtrail:UpdateTrail",
      "account:*",
      "billing:*",
      "payments:*"
    ]
    effect = "Deny"
    resources = [
      "*"
    ]
  }
}


resource "aws_iam_policy" "user-malicious-activity-deny-policy" {
  name   = "hmpps-user-malicious-activity-deny-policy"
  policy = data.aws_iam_policy_document.user-malicious-activity-deny-policy.json
}
