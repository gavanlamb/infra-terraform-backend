region="ap-southeast-2"
username="terraform-ap-southeast-2"
tf_bucket_name="expensely-terraform-state"
tf_dynamodb_name="expensely-terraform-lock"
tf_iam_path="terraform/ap-southeast-2"
tf_iam_policy_prefix="terraform-ap-southeast-2"
tf_key_name="terraform"
azure_devops_account_details=[
  {
    id = 0
    azure_devops_project_name = "Platform"
    azure_devops_variable_group_name = "terraform.infrastructure"
    terraform_artifact_name = "terraform.infrastructure"
    profile_name = null
  },
  {
    id = 1
    azure_devops_project_name = "Platform"
    azure_devops_variable_group_name = "terraform.platform.production"
    terraform_artifact_name = "terraform.platform.production"
    profile_name = "test"
  },
  {
    id = 2
    azure_devops_project_name = "Platform"
    azure_devops_variable_group_name = "terraform.platform.preview"
    terraform_artifact_name = "terraform.platform.preview"
    profile_name = "test"
  },
  {
    id = 3
    azure_devops_project_name = "Kronos"
    azure_devops_variable_group_name = "terraform.kronos.production"
    terraform_artifact_name = "terraform.kronos.production"
    profile_name = "test"
  },
  {
    id = 4
    azure_devops_project_name = "Kronos"
    azure_devops_variable_group_name = "terraform.kronos.preview"
    terraform_artifact_name = "terraform.kronos.preview"
    profile_name = "test"
  },
  {
    id = 5
    azure_devops_project_name = "Security"
    azure_devops_variable_group_name = "terraform.security.production"
    terraform_artifact_name = "terraform.security.production"
    profile_name = "test"
  },
  {
    id = 6
    azure_devops_project_name = "Security"
    azure_devops_variable_group_name = "terraform.security.preview"
    terraform_artifact_name = "terraform.security.preview"
    profile_name = "test"
  },
  {
    id = 7
    azure_devops_project_name = "Shared"
    azure_devops_variable_group_name = "terraform.shared.production"
    terraform_artifact_name = "terraform.shared.production"
    profile_name = "test"
  },
  {
    id = 8
    azure_devops_project_name = "Shared"
    azure_devops_variable_group_name = "terraform.shared.preview"
    terraform_artifact_name = "terraform.shared.preview"
    profile_name = "test"
  }
]