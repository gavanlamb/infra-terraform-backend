variable "region" {
  type = string
}
variable "provider_role_arn" {
  type = string
}

variable "azure_devops_org_service_url" {
  type = string
}
variable "azure_devops_personal_access_token" {
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
