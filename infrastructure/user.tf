variable "username" {
  type = string
}

resource "aws_iam_user" "cicd" {
  name = var.username
  path = "/cicd/"
  force_destroy = true
  tags = local.default_tags

  lifecycle {
    prevent_destroy = true
  }
}
resource "aws_iam_access_key" "cicd" {
  user = aws_iam_user.cicd.name

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_user_policy_attachment" "cicd_remote_state" {
  user = aws_iam_user.cicd.name
  policy_arn = module.backend.bucket_iam_policy_arn
}
resource "aws_iam_user_policy_attachment" "cicd_remote_lock" {
  user = aws_iam_user.cicd.name
  policy_arn = module.backend.dynamodb_iam_policy_arn
}
resource "aws_iam_user_policy_attachment" "cicd_remote_state_key" {
  user = aws_iam_user.cicd.name
  policy_arn = module.backend.kms_key_iam_policy_arn
}
