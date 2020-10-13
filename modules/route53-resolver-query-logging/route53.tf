resource "aws_route53_resolver_query_log_config" "example" {
  name            = local.route53_query_log_config_name
  destination_arn = aws_cloudwatch_log_group.this.arn
  tags            = var.tags
}
