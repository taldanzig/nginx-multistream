provider "aws" {
  region                  = var.aws_region
  profile                 = var.aws_profile
  allowed_account_ids     = [var.aws_account_id]
}

# Can't use interopolations so bucket and table must exist first
terraform {
  backend "s3" {
    bucket         = "terraform-state-445070157823"
    key            = "multiplexer/terraform.tfstate"
    dynamodb_table = "terraform-lock"
    region         = "us-west-2"
    encrypt        = true
  }
}
