variable "tf_bucket_name" {
  type = string
}
variable "tf_dynamodb_name" {
  type = string
}
variable "tf_iam_path" {
  type = string
}
variable "tf_iam_policy_prefix" {
  type = string
}
variable "tf_key_name" {
  type = string
}

module "backend" {
  source = "github.com/expensely/terraform-module-aws-backend"
  environment = "Terraform"
  name = "Terraform Backend"
  bucket_name = var.tf_bucket_name
  dynamodb_name = var.tf_dynamodb_name
  iam_path = var.tf_iam_path
  iam_policy_prefix = var.tf_iam_policy_prefix
  key_name = var.tf_key_name
  tags = local.default_tags
}
