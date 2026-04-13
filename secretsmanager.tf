##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

# Secrets saving
resource "aws_secretsmanager_secret" "atlas_cred" {
  count       = try(var.settings.admin_user.enabled, false) ? 1 : 0
  name        = "${local.secret_store_path}/mongodbatlas/${module.cluster.cluster_name}/admin-user-credentials"
  description = "Mongodbatlas Admin credentials - ${module.cluster.cluster_admin_user} - ${module.cluster.cluster_name}"
  kms_key_id  = try(var.settings.admin_user.kms_key_id, null)
  tags        = local.all_tags
}

# If rotation lambda is not provided, create the secret version with the credentials
resource "aws_secretsmanager_secret_version" "atlas_cred" {
  count         = try(var.settings.admin_user.enabled, false) && try(var.settings.admin_user.rotation_lambda_name, "") == "" ? 1 : 0
  secret_id     = aws_secretsmanager_secret.atlas_cred[count.index].id
  secret_string = jsonencode(module.cluster.cluster_credentials)
}

# If rotation lambda is provided, create an initial secret version but ignore changes to it afterwards
resource "aws_secretsmanager_secret_version" "atlas_cred_rotated" {
  count         = try(var.settings.admin_user.enabled, false) && try(var.settings.admin_user.rotation_lambda_name, "") != "" ? 1 : 0
  secret_id     = aws_secretsmanager_secret.atlas_cred[0].id
  secret_string = jsonencode(module.cluster.cluster_credentials)
  lifecycle {
    ignore_changes = [
      secret_string,
      version_stages
    ]
  }
}

data "aws_lambda_function" "rotation_function" {
  count         = try(var.settings.admin_user.enabled, false) && try(var.settings.admin_user.rotation_lambda_name, "") != "" ? 1 : 0
  function_name = var.settings.admin_user.rotation_lambda_name
}

resource "aws_secretsmanager_secret_rotation" "user" {
  count               = try(var.settings.admin_user.enabled, false) && try(var.settings.admin_user.rotation_lambda_name, "") != "" ? 1 : 0
  secret_id           = aws_secretsmanager_secret.atlas_cred[0].id
  rotation_lambda_arn = data.aws_lambda_function.rotation_function[count.index].arn
  rotate_immediately  = try(var.settings.admin_user.rotate_immediately, true)
  rotation_rules {
    automatically_after_days = try(var.settings.admin_user.rotation_period, 90)
    duration                 = try(var.settings.admin_user.rotation_duration, "1h")
  }
}
