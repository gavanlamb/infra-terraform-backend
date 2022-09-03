region="ap-southeast-2"
username="terraform-ap-southeast-2"
tf_bucket_name="expensely-terraform-state"
tf_dynamodb_name="expensely-terraform-lock"
tf_iam_path="terraform/ap-southeast-2"
tf_iam_policy_prefix="terraform-ap-southeast-2"
tf_key_name="terraform"
azure_devops_account_details=[
  {
    azure_devops_project_name = "Platform"
    environment = "Production"
    profile_name = "test"
  },
  {
    azure_devops_project_name = "Platform"
    environment = "Preview"
    profile_name = "test"
  }
]