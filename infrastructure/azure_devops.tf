variable "azure_devops_org_service_url" {
  type = string
}
variable "azure_devops_personal_access_token" {
  type = string
}
variable "azure_devops_account_details" {
  type = list(object({
    id = number
    azure_devops_project_name = string
    azure_devops_variable_group_name = string
    terraform_artifact_name = string
    profile_name = string
  }))
}

data "azuredevops_project" "current" {
  for_each = {for adad in var.azure_devops_account_details:  adad.id => adad}
  name = each.value.azure_devops_project_name
}
resource "azuredevops_variable_group" "credentials" {
  for_each = {for adad in var.azure_devops_account_details:  adad.id => adad}
  project_id = data.azuredevops_project.current[each.key].id
  name = lower(each.value.azure_devops_variable_group_name)
  description = "Environment variables for Terraform"
  allow_access = true

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
    value = lower(each.value.terraform_artifact_name)
  }

  variable {
    name = "TF_CLI_ARGS_INIT"
    value = each.value.profile_name == null ? "-backend-config=\"dynamodb_table=${var.tf_dynamodb_name}\" -backend-config=\"bucket=${var.tf_bucket_name}\" -backend-config=\"region=${var.region}\"" : "-backend-config=\"dynamodb_table=${var.tf_dynamodb_name}\" -backend-config=\"bucket=${var.tf_bucket_name}\" -backend-config=\"region=${var.region}\" -backend-config=\"profile=${each.value.profile_name}\""
  }

  variable {
    name = "INFRACOST_API_KEY"
    secret_value = "ico-mlCr1MM6SRcRiZMObUZOTHucgtH2Lpgt"
    is_secret = true
  }
}
