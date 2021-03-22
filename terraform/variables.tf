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

variable "youtube_key" {
  type = string
  description = "YouTube stream key"
}

variable "fb_key" {
  type = string
  description = "Facebook stream key"
}

variable "password" {
  type = string
  description = "Streaming password"
}
