resource "aws_s3_bucket" "prime-test-terraform-state-bucket" {
  bucket = "prime-test-terraform-state-bucket"
}

resource "aws_s3_bucket_public_access_block" "prime-test-block" {
  bucket = aws_s3_bucket.prime-test-terraform-state-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
