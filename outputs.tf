##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

output "cluster_name" {
  value = module.cluster.cluster_name
}

output "cluster_id" {
  value = module.cluster.cluster_id
}

output "cluster_version" {
  value = module.cluster.cluster_version
}

output "cluster_connection_strings" {
  value = module.cluster.cluster_connection_strings
}

output "cluster_state" {
  value = module.cluster.cluster_state
}

output "cluster_containers" {
  value = module.cluster.cluster_containers
}

output "cluster_server_type" {
  value = module.cluster.cluster_server_type
}

output "cluster_admin_user" {
  value = module.cluster.cluster_admin_user
}

output "cluster_secrets_credentials" {
  description = "Name of the AWS Secrets Manager secret storing the cluster admin credentials."
  value       = try(var.settings.admin_user.enabled, false) ? aws_secretsmanager_secret.atlas_cred[0].name : ""
}
