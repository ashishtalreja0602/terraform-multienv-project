resource "aws_dynamodb_table" "my_dynamo_db_table " {
  name           = var.dynamodb_table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "lockID"

  attribute {
    name = "lockID"
    type = "S"
  }
}