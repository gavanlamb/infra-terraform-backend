module "backend" {
  source = "github.com/expensely/terraform-module-aws-backend"
  environment = var.environment
  name = "Terraform Backend"
  bucket_name = var.bucket_name
  dynamodb_name = var.dynamodb_name
  iam_path = var.iam_path
  iam_policy_prefix = var.iam_policy_prefix
  key_name = "terraform"
  username = var.username
  tags = local.default_tags
}