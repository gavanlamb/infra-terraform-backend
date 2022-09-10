region="ap-southeast-2"
tf_bucket_name="expensely-terraform-state"
tf_dynamodb_name="expensely-terraform-lock"
tf_iam_path="terraform/ap-southeast-2"
tf_iam_policy_prefix="terraform-ap-southeast-2"
tf_key_name="terraform"
azure_devops_projects_details=[
  {
    project_name = "Platform"
    name = "terraform.infrastructure"
    workspace_key_prefix= "terraform"
  },
  {
    project_name = "Platform"
    name = "terraform.platform.production"
    workspace_key_prefix = "platform"
  },
  {
    project_name = "Platform"
    name = "terraform.platform.preview"
    workspace_key_prefix= "platform"
  },
  {
    project_name = "Kronos"
    name = "terraform.kronos.production"
    workspace_key_prefix= "kronos"
  },
  {
    project_name = "Kronos"
    name = "terraform.kronos.preview"
    workspace_key_prefix= "kronos"
  },
  {
    project_name = "Security"
    name = "terraform.security.production"
    workspace_key_prefix= "security"
  },
  {
    project_name = "Security"
    name = "terraform.security.preview"
    workspace_key_prefix= "security"
  },
  {
    project_name = "Shared"
    name = "terraform.shared.production"
    workspace_key_prefix= "shared"
  },
  {
    project_name = "Shared"
    name = "terraform.shared.preview"
    workspace_key_prefix= "shared"
  }
]