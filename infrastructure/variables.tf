variable "region" {
  type = string
}
variable "provider_role_arn" {
  type = string
}

locals {
  default_tags = {
    Application = "Expensely"
    Team = "Platform"
    ManagedBy = "Terraform"
    Environment = "Terraform"
  }
}
