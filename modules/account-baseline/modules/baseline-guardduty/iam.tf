data "aws_iam_policy_document" "cloudwatch" {	
  statement {	
    sid       = "AWSEvents"	
    effect    = "Allow"	
    actions   = ["logs:*"]	
    resources = ["*"]	
  }	
}


data "aws_iam_policy_document" "assume" {	
  statement {	
    effect  = "Allow"	
    actions = ["sts:AssumeRole"]	
    principals {	
      type        = "Service"	
      identifiers = ["events.amazonaws.com"]	
    }	
  }	
}	


resource "aws_iam_policy" "cloudwatch" {	
  name   = local.cloudwatch_iam_policy_name	
  policy = data.aws_iam_policy_document.cloudwatch.json	
}	


resource "aws_iam_role" "cloudwatch" {	
  name               = local.cloudwatch_iam_role_name	
  assume_role_policy = data.aws_iam_policy_document.assume.json	
  tags               = var.tags	
}	


resource "aws_iam_role_policy_attachment" "cloudwatch" {	
  role       = aws_iam_role.cloudwatch.name	
  policy_arn = aws_iam_policy.cloudwatch.arn	
}
