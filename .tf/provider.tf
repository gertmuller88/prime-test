provider "aws" {
  region     = var.aws_region
  access_key = ""
  secret_key = ""
}

data "aws_availability_zones" "available" {}

provider "http" {}
