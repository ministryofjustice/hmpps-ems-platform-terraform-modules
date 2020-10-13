resource "aws_route53_resolver_query_log_config" "this" {
  name            = local.route53_query_log_config_name
  destination_arn = aws_cloudwatch_log_group.this.arn
  tags            = var.tags
}


resource "aws_route53_resolver_query_log_config_association" "this" {
  resolver_query_log_config_id = aws_route53_resolver_query_log_config.this.id
  resource_id                  = var.vpc_id
}
