provider "aws" {
  region  = var.region
  assume_role {
    role_arn = var.provider_role_arn
  }
}

provider "azuredevops" {
  org_service_url = var.azure_devops_org_service_url
  personal_access_token = var.azure_devops_personal_access_token
}
