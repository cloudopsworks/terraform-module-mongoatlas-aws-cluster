##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#
# Moved blocks for migration from terraform-module-mongoatlas-cluster (direct resources)
# to terraform-module-mongoatlas-aws-cluster (module.cluster sub-module).
#
# Apply these when replacing the old terraform-module-mongoatlas-cluster source with
# this module. They relocate existing state entries into the module.cluster namespace
# without destroying and re-creating any infrastructure.
#

# Atlas cluster
moved {
  from = mongodbatlas_advanced_cluster.this
  to   = module.cluster.mongodbatlas_advanced_cluster.this
}

# Cloud backup schedule (count-based, only index 0 exists)
moved {
  from = mongodbatlas_cloud_backup_schedule.this[0]
  to   = module.cluster.mongodbatlas_cloud_backup_schedule.this[0]
}

# Backup snapshot export bucket (count-based)
moved {
  from = mongodbatlas_cloud_backup_snapshot_export_bucket.this[0]
  to   = module.cluster.mongodbatlas_cloud_backup_snapshot_export_bucket.this[0]
}

# Admin database user (count-based)
moved {
  from = mongodbatlas_database_user.admin_user[0]
  to   = module.cluster.mongodbatlas_database_user.admin_user[0]
}

# Password resources (count-based)
moved {
  from = random_password.randompass[0]
  to   = module.cluster.random_password.randompass[0]
}

moved {
  from = random_password.randompass_rotated[0]
  to   = module.cluster.random_password.randompass_rotated[0]
}

moved {
  from = time_rotating.randompass[0]
  to   = module.cluster.time_rotating.randompass[0]
}
