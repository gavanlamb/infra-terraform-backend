variable "environment" {
  type = string
}
variable "region" {
  type = string
}
variable "bucket_name" {
  type = string
}
variable "dynamodb_name" {
  type = string
}
variable "username" {
  type = string
}
variable "iam_path" {
  type = string
}

locals {
  default_tags = {
    Application = "Expensely"
    Team = "Expensely Core"
    ManagedBy = "Terraform"
    Environment = var.environment
  }
}
