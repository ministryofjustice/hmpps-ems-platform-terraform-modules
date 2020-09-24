resource "aws_iam_group" "this" {
  name = var.group_name
}


# --- Handle extra policies provided by input
resource "aws_iam_group_policy_attachment" "input_policy_attachment" {
  for_each   = toset(var.policy_arns)
  group      = aws_iam_group.this.name
  policy_arn = each.value
}
