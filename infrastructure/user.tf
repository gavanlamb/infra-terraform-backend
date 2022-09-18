resource "aws_iam_user" "cicd" {
  for_each = {for adad in var.azure_devops_projects_details:  adad.name => adad}
  name = each.value.name
  path = "/cicd/"
  force_destroy = true
  tags = local.default_tags

  lifecycle {
    prevent_destroy = true
  }
}
resource "aws_iam_access_key" "cicd" {
  for_each = {for adad in var.azure_devops_projects_details:  adad.name => adad}
  user = aws_iam_user.cicd[each.key].name
}

resource "aws_iam_user_policy_attachment" "cicd_remote_state" {
  for_each = {for adad in var.azure_devops_projects_details:  adad.name => adad}
  user = aws_iam_user.cicd[each.key].name
  policy_arn = module.backend.bucket_iam_policy_arn
}
resource "aws_iam_user_policy_attachment" "cicd_remote_lock" {
  for_each = {for adad in var.azure_devops_projects_details:  adad.name => adad}
  user = aws_iam_user.cicd[each.key].name
  policy_arn = module.backend.dynamodb_iam_policy_arn
}
resource "aws_iam_user_policy_attachment" "cicd_remote_state_key" {
  for_each = {for adad in var.azure_devops_projects_details:  adad.name => adad}
  user = aws_iam_user.cicd[each.key].name
  policy_arn = module.backend.kms_key_iam_policy_arn
}
resource "aws_iam_role" "assume_role" {
  name = "assume_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }
  }
}