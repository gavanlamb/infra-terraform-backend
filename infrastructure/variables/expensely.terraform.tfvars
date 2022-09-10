region="ap-southeast-2"
username="terraform-ap-southeast-2"
tf_bucket_name="expensely-terraform-state"
tf_dynamodb_name="expensely-terraform-lock"
tf_iam_path="terraform/ap-southeast-2"
tf_iam_policy_prefix="terraform-ap-southeast-2"
tf_key_name="terraform"
azure_devops_projects_details=[
  {
    id = 0
    name = "Platform"
    variable_group_name = "terraform.infrastructure"
    terraform_artifact_name = "terraform.infrastructure"
    workspace_key_prefix= "terraform"
    aws_profile_name = null
  },
  {
    id = 1
    name = "Platform"
    variable_group_name = "terraform.platform.production"
    terraform_artifact_name = "terraform.platform.production"
    workspace_key_prefix= "platform"
    aws_profile_name = "test"
  },
  {
    id = 2
    name = "Platform"
    variable_group_name = "terraform.platform.preview"
    terraform_artifact_name = "terraform.platform.preview"
    workspace_key_prefix= "platform"
    aws_profile_name = "test"
  },
  {
    id = 3
    name = "Kronos"
    variable_group_name = "terraform.kronos.production"
    terraform_artifact_name = "terraform.kronos.production"
    workspace_key_prefix= "kronos"
    aws_profile_name = "test"
  },
  {
    id = 4
    name = "Kronos"
    variable_group_name = "terraform.kronos.preview"
    terraform_artifact_name = "terraform.kronos.preview"
    workspace_key_prefix= "kronos"
    aws_profile_name = "test"
  },
  {
    id = 5
    name = "Security"
    variable_group_name = "terraform.security.production"
    terraform_artifact_name = "terraform.security.production"
    workspace_key_prefix= "security"
    aws_profile_name = "test"
  },
  {
    id = 6
    name = "Security"
    variable_group_name = "terraform.security.preview"
    terraform_artifact_name = "terraform.security.preview"
    workspace_key_prefix= "security"
    aws_profile_name = "test"
  },
  {
    id = 7
    name = "Shared"
    variable_group_name = "terraform.shared.production"
    terraform_artifact_name = "terraform.shared.production"
    workspace_key_prefix= "shared"
    aws_profile_name = "test"
  },
  {
    id = 8
    name = "Shared"
    variable_group_name = "terraform.shared.preview"
    terraform_artifact_name = "terraform.shared.preview"
    workspace_key_prefix= "shared"
    aws_profile_name = "test"
  }
]