resource "aws_kms_key" "prime-test-terraform-state-bucket-key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_alias" "prime-test-terraform-state-bucket-key-alias" {
  name          = "alias/prime-test-terraform-state-bucket-key"
  target_key_id = aws_kms_key.prime-test-terraform-state-bucket-key.key_id
}
