resource "aws_dynamodb_table" "this" {
  name         = local.dynamodb_table_name
  billing_mode = "PROVISIONED"
  hash_key     = "TunnelId"
  range_key  = "VpnConnectionId"
  read_capacity  = 5
  write_capacity = 5


  attribute {
    name = "TunnelId"
    type = "S"
  }

    attribute {
    name = "VpnConnectionId"
    type = "S"
  }

  # --- State needs to be defined by the lambda

  tags = var.tags

}
