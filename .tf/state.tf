resource "aws_dynamodb_table" "prime-test-terraform-state" {
  name           = "prime-test-terraform-state"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}