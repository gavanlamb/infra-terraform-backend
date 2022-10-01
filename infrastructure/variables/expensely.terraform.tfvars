region="ap-southeast-2"
tf_bucket_name="expensely-terraform-state"
tf_dynamodb_name="expensely-terraform-lock"
tf_iam_path="terraform/ap-southeast-2"
tf_iam_policy_prefix="terraform-ap-southeast-2"
tf_key_name="terraform"
provider_role_arn="arn:aws:iam::931649473445:role/terraform.infrastructure"
azure_devops_projects_details=[
  {
    project_name = "Platform"
    name = "terraform.platform"
    workspace_key_prefix = "platform"
    assumeRoleUserArns = [
      "arn:aws:iam::829991159560:role/terraform.infrastructure",
      "arn:aws:iam::151170476258:role/terraform.infrastructure",
      "arn:aws:iam::172837312601:role/terraform.infrastructure",
      "arn:aws:iam::556018441473:role/terraform.infrastructure",
      "arn:aws:iam::087484524822:role/terraform.infrastructure",
      "arn:aws:iam::104633789203:role/terraform.infrastructure",
      "arn:aws:iam::266556396524:role/terraform.infrastructure",
      "arn:aws:iam::217292076671:role/terraform.infrastructure",
      "arn:aws:iam::258593516853:role/terraform.infrastructure",
      "arn:aws:iam::931649473445:role/terraform.infrastructure"
    ]
  },
  {
    project_name = "Time"
    name = "terraform.time.production"
    workspace_key_prefix= "time"
    assumeRoleUserArns = [
      "arn:aws:iam::104633789203:role/terraform.infrastructure",
      "arn:aws:iam::556018441473:role/terraform.infrastructure",
      "arn:aws:iam::266556396524:role/terraform.infrastructure"
    ]
  },
  {
    project_name = "Time"
    name = "terraform.time.preview"
    workspace_key_prefix= "time"
    assumeRoleUserArns = [
      "arn:aws:iam::829991159560:role/terraform.infrastructure",
      "arn:aws:iam::151170476258:role/terraform.infrastructure",
      "arn:aws:iam::172837312601:role/terraform.infrastructure"
    ]
  },
  {
    project_name = "User"
    name = "terraform.user.production"
    workspace_key_prefix= "user"
    assumeRoleUserArns = [
      "arn:aws:iam::266556396524:role/terraform.infrastructure",
      "arn:aws:iam::556018441473:role/terraform.infrastructure"
    ]
  },
  {
    project_name = "User"
    name = "terraform.user.preview"
    workspace_key_prefix= "user"
    assumeRoleUserArns = [
      "arn:aws:iam::172837312601:role/terraform.infrastructure",
      "arn:aws:iam::151170476258:role/terraform.infrastructure"
    ]
  },
  {
    project_name = "Shared"
    name = "terraform.shared.production"
    workspace_key_prefix= "shared"
    assumeRoleUserArns = [
      "arn:aws:iam::556018441473:role/terraform.infrastructure"
    ]
  },
  {
    project_name = "Shared"
    name = "terraform.shared.preview"
    workspace_key_prefix= "shared"
    assumeRoleUserArns = [
      "arn:aws:iam::151170476258:role/terraform.infrastructure"
    ]
  }
]
