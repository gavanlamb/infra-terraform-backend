variable "azure_devops_project_name" {
  type = string
}
variable "azure_devops_org_service_url" {
  type = string
}
variable "azure_devops_personal_access_token" {
  type = string
}
variable "azure_devops_account_details" {
  type = list(object({
    azure_devops_project_name = string
    environment = string
    profile_name = string
  }))
}

data "azuredevops_project" "current" {
  for_each = var.azure_devops_account_details
  name = each.value.azure_devops_project_name
}
resource "azuredevops_variable_group" "credentials" {
  for_each = var.azure_devops_account_details
  project_id = data.azuredevops_project.current[each.key].id
  name = "terraform.${each.environment}"
  description = "Environment variables for Terraform"
  allow_access = true

  // TODO create template to export these to ENV variables
  variable {
    name = "TF_BACKEND_AWS_KEY_ID"
    secret_value = aws_iam_access_key.cicd.id
    is_secret = true
  }

  variable {
    name = "TF_BACKEND_AWS_SECRET_KEY"
    secret_value = aws_iam_access_key.cicd.secret
    is_secret = true
  }

  variable {
    name = "TF_BACKEND_AWS_REGION"
    value = var.region
  }
  
  variable {
    name = "TF_ARTIFACT_NAME"
    value = "terraform.production.${tolower(var.region)}"
  }
  
  variable {
    name = "TF_CLI_ARGS_INIT"
    value = "-backend-config=\"dynamodb_table=${var.tf_dynamodb_name}\" -backend-config=\"bucket=${var.tf_bucket_name}\" -backend-config=\"region=${var.region}\" -backend-config=\"profile=${var.region}\""
  }
}
