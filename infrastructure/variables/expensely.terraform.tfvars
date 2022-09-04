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
  }
]