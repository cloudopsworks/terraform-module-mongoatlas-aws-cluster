##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

module "cluster" {
  source = "git::https://github.com/cloudopsworks/terraform-module-mongoatlas-cluster.git?ref=v1.2.0-refactor-generic-no-cloud-deps.4"

  is_hub       = var.is_hub
  spoke_def    = var.spoke_def
  org          = var.org
  extra_tags   = var.extra_tags
  name_prefix  = var.name_prefix
  name         = var.name
  project_id   = var.project_id
  project_name = var.project_name
  region       = data.aws_region.current.id
  settings     = var.settings
}
