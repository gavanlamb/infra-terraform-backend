variable "environment" {
  type = string
}
variable "region" {
  type = string
}
variable "username" {
  type = string
}

locals {
  default_tags = {
    Application = "Expensely"
    Team = "Platform"
    ManagedBy = "Terraform"
    Environment = var.environment
  }
}
