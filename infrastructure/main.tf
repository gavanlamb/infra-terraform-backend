﻿module "backend" {
  source = "github.com/gavanlamb/terraform-module-aws-backend"
  environment = var.environment
  name = "Terraform Backend"
  iam_path = "terraform"
  username = "terraform"
  user_tags = local.default_tags
  bucket_name = var.bucket_name
  bucket_tags = local.default_tags
  dynamodb_name = var.dynamodb_name
  dynamodb_tags = local.default_tags
}