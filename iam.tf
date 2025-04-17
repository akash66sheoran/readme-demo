resource "aws_iam_role" "ec2_role" {
  name = var.ec2_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

}

resource "aws_iam_role_policy_attachment" "managed_policy_attachment" {
  for_each   = toset(var.managed_policy_arns)
  role       = aws_iam_role.ec2_role.name
  policy_arn = each.value
}

# Get all policy files in the policies folder
locals {
  policy_files = fileset("${path.module}/policies", "*.json")
}

# Create an IAM policy for each file in the folder
resource "aws_iam_role_policy" "custom_policy" {
  for_each = { for filename in local.policy_files : filename => file("${path.module}/policies/${filename}") }

  name   = replace(each.key, ".json", "")  # Remove the .json extension from the policy name
  policy = each.value
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = var.iam_instance_profile
  role = aws_iam_role.ec2_role.id
}