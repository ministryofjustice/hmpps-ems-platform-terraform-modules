resource "aws_iam_user" "this" {
  name          = var.username
  force_destroy = var.force_destroy
  path          = var.path
  tags          = local.tags
}


resource "aws_iam_user_group_membership" "this" {
  count  = length(local.group_membership) > 0 ? 1 : 0
  user   = aws_iam_user.this.name
  groups = local.group_membership
}
