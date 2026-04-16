##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

locals {
  hoop_enabled       = try(var.settings.hoop.enabled, false) && try(var.settings.admin_user.enabled, false)
  hoop_secret_prefix = try(var.settings.hoop.community, true) ? "_aws" : "_envs/aws"
  hoop_secret_sep    = try(var.settings.hoop.community, true) ? ":" : "#"
  hoop_use_private   = try(var.settings.hoop.use_private_endpoint, false)
  hoop_conn_str_key  = local.hoop_use_private ? "private_connection_string" : "connection_string"
}

output "hoop_connections" {
  description = <<-EOD
    Hoop connection definition for the cluster admin user. Pass directly as the `connections`
    input to terraform-module-hoop-connection. Returns null when hoop.enabled or
    admin_user.enabled is false.
    Supports community (_aws:) and enterprise (_envs/aws/) secret formats via settings.hoop.community.
    AWS is the only cloud provider supported by terraform-module-hoop-connection.
  EOD
  value = local.hoop_enabled ? {
    "admin" = {
      name           = "mongo-db-${lower(module.cluster.cluster_name)}-admin"
      agent_id       = var.settings.hoop.agent_id
      type           = "database"
      subtype        = "mongodb"
      tags           = try(var.settings.hoop.tags, {})
      access_control = toset(try(var.settings.hoop.access_control, []))
      access_modes = {
        connect  = "enabled"
        exec     = "enabled"
        runbooks = "enabled"
        schema   = "enabled"
      }
      import  = try(var.settings.hoop.import, false)
      secrets = {
        "envvar:CONNECTION_STRING" = "${local.hoop_secret_prefix}${local.hoop_secret_sep}${aws_secretsmanager_secret.atlas_cred[0].name}${local.hoop_secret_sep}${local.hoop_conn_str_key}"
      }
    }
  } : null

  precondition {
    condition     = !local.hoop_enabled || try(var.settings.hoop.agent_id, "") != ""
    error_message = "settings.hoop.agent_id must be set (as a Hoop agent UUID) when settings.hoop.enabled is true."
  }
}
