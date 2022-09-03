﻿variable "environment" {
  type = string
}
variable "region" {
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
