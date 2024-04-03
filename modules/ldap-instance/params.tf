// Root Directory parameter. Generated by Terraform random.
// In production, it should be Secret Manager instead of SSM parameter.
// But this is designed to run on free tier so...
resource "random_password" "directory_root_password" {
  length = 8
  // No special character to avoid error when rendering template
  special = false
}

resource "aws_ssm_parameter" "directory_root_password_param" {
  name  = "/ldap/instancepassword"
  type  = "String"
  value = random_password.directory_root_password.result
}