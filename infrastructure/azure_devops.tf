variable "azure_devops_org_service_url" {
  type = string
}
variable "azure_devops_personal_access_token" {
  type = string
}
variable "azure_devops_projects_details" {
  type = list(object({
    project_name = string
    name = string
    workspace_key_prefix = string
  }))
}

data "azuredevops_project" "current" {
  for_each = {for adad in var.azure_devops_projects_details:  adad.name => adad}
  name = each.value.project_name
}
resource "azuredevops_variable_group" "credentials" {
  for_each = {for adad in var.azure_devops_projects_details:  adad.name => adad}
  project_id = data.azuredevops_project.current[each.key].id
  name = lower(each.value.name)
  description = "Environment variables for Terraform"
  allow_access = true

  variable {
    name = "TF_BACKEND_AWS_KEY_ID"
    secret_value = aws_iam_access_key.cicd[each.key].id
    is_secret = true
  }

  variable {
    name = "TF_BACKEND_AWS_SECRET_KEY"
    secret_value = aws_iam_access_key.cicd[each.key].secret
    is_secret = true
  }

  variable {
    name = "TF_BACKEND_AWS_REGION"
    value = var.region
  }

  variable {
    name = "TF_ARTIFACT_NAME"
    value = lower(each.value.name)
  }

  variable {
    name = "TF_CLI_ARGS_INIT"
    value = "-backend-config=\"dynamodb_table=${var.tf_dynamodb_name}\" -backend-config=\"bucket=${var.tf_bucket_name}\" -backend-config=\"region=${var.region}\" -backend-config=\"encrypt=true\" -backend-config=\"key=terraform.tfstate\" -backend-config=\"workspace_key_prefix=${each.value.workspace_key_prefix}\""
  }

  variable {
    name = "INFRACOST_API_KEY"
    secret_value = "ico-mlCr1MM6SRcRiZMObUZOTHucgtH2Lpgt"
    is_secret = true
  }
}
