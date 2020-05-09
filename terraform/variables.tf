variable "aws_account_id" {
  type        = string
  description = "AWS account ID to use to provision resources"
}

variable "aws_region" {
  type        = string
  default     = "us-west-2"
  description = "AWS region"
}

variable "aws_profile" {
  type        = string
  description = "AWS profile."
}

variable "vpc_id" {
  type    = string
  default = "vpc-3a49775d"
}

variable "subnet_ids" {
  type    = list(string)
  default = [
    "subnet-022a6065",
    "subnet-69096420",
    "subnet-8b708dd0",
    "subnet-e8b79ac0",
  ]
}
