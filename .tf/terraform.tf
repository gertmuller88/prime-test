terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket         = "prime-test-terraform-state-bucket"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    kms_key_id     = "alias/prime-test-terraform-state-bucket-key"
    dynamodb_table = "prime-test-terraform-state"
  }
}
