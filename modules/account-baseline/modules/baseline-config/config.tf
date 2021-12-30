data "aws_iam_policy_document" "assume" {
  statement {
    sid    = "AllowConfigAssumeRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "config.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    sid    = "AllowConfigS3Actions"
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    resources = [
      module.config_s3_bucket.arn,
      "${module.config_s3_bucket.arn}/*"
    ]
  }
}

resource "aws_iam_role" "this" {
  name               = local.config_iam_role_name
  assume_role_policy = data.aws_iam_policy_document.assume.json
}

resource "aws_iam_policy" "this" {
  name   = local.config_iam_policy_name
  policy = data.aws_iam_policy_document.s3_policy.json
}

resource "aws_config_configuration_recorder" "this" {
  name     = local.config_recorder_name
  role_arn = aws_iam_role.this.arn
}

resource "aws_config_delivery_channel" "this" {
  name           = local.config_delivery_channel_name
  s3_bucket_name = module.config_s3_bucket.id
  depends_on     = [aws_config_configuration_recorder.this]
}

resource "aws_config_configuration_recorder_status" "this" {
  name       = aws_config_configuration_recorder.this.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.this]
}

resource "aws_iam_role_policy_attachment" "managed" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}