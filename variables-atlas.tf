##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

variable "name_prefix" {
  description = "Prefix for the name of the resources"
  type        = string
  default     = ""
}

variable "name" {
  description = "Name of the resource"
  type        = string
  default     = ""
}

variable "project_id" {
  description = "(optional) The ID of the project where the cluster will be created"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "(optional) The name of the project where the cluster will be created"
  type        = string
  default     = ""
}

##
# Variable entries as YAML
# settings:
#   cluster_type: "REPLICASET"         # (Optional) REPLICASET | SHARDED | GEOSHARDED. Default: "REPLICASET"
#   major_version: 7.0                 # (Optional) MongoDB major version. Default: null
#   termination_protection: true       # (Optional) Enable termination protection. Default: null
#   version_release: "LTS"             # (Optional) LTS | CONTINUOUS. Default: "LTS"
#   encryption_at_rest_enabled: false  # (Optional) Enable encryption at rest. Default: false
#   encryption_at_rest_provider: "AWS" # (Optional) AWS | GCP | AZURE. Default: "AWS"
#   cloud_provider: "AWS"              # (Optional) Default cloud provider for backup export/copy: AWS | GCP | AZURE. Default: "AWS"
#   bi_connector:
#     enabled: false                   # (Optional) Enable BI Connector. Default: false
#     read_preference: "secondary"     # (Optional) primary | secondary | primaryPreferred | secondaryPreferred | nearest
#   admin_user:
#     enabled: false                   # (Optional) Create Atlas admin user. Default: false
#     username: "my-admin"             # (Optional) Username. Default: auto-generated
#     auth_database: "admin"           # (Optional) Authentication database. Default: "admin"
#     use_external_rotation: false     # (Optional) When true, an external rotation manager (e.g. Lambda) handles the password. Default: false
#     rotation_lambda_name: "fn-name"  # (Optional) AWS Lambda function name for Secrets Manager rotation. Required when use_external_rotation is true.
#     rotation_period: 90              # (Optional) Lambda rotation period in days. Default: 90
#     rotation_duration: "1h"          # (Optional) Lambda rotation execution duration. Default: "1h"
#     rotate_immediately: true         # (Optional) Rotate the secret immediately on first creation (AWS Secrets Manager). Default: true
#     password_rotation_period: 90     # (Optional) Terraform time_rotating period in days. Default: 90
#     kms_key_id: "arn:..."            # (Optional) AWS KMS key ARN or Alias for Secrets Manager secret encryption
#   advanced:
#     default_write_concern: "majority" # (Optional) Write concern. Default: null
#     javascript: false                 # (Optional) Enable JavaScript. Default: null
#     tls_protocol: "TLS1_2"           # (Optional) TLS1_0 | TLS1_1 | TLS1_2 | TLS1_3. Default: null
#     no_table_scan: false             # (Optional) Disable table scans. Default: null
#     oplog_size: 50                   # (Optional) Oplog size in MB. Default: null
#     oplog_retention: 30              # (Optional) Oplog retention in hours. Default: null
#     bi:
#       sample_size: 1000              # (Optional) BI Connector sample size. Default: null
#       refresh_interval: 60           # (Optional) BI Connector refresh interval in seconds. Default: null
#     transaction_lifetime: 30         # (Optional) Transaction lifetime in minutes. Default: null
#   backup:
#     enabled: false                   # (Optional) Enable cloud backup. Default: false
#     hour_of_day: 0                   # (Optional) Backup hour 0-23. Default: 0
#     minute_of_hour: 0                # (Optional) Backup minute 0-59. Default: 0
#     restore_window_days: 1           # (Optional) Restore window in days. Default: 1
#     auto_export: false               # (Optional) Enable automatic export. Default: null
#     export_prefix: ""                # (Optional) Use org and group names as export prefix. Default: null
#     hourly:
#       interval: 6                    # (Optional) Frequency in hours (1,2,4,6,8,12). Default: 1
#       retention_unit: "days"         # (Optional) days. Default: "days"
#       retention_value: 2             # (Optional) Retention value. Default: 1
#     daily:
#       interval: 1                    # (Optional) Frequency (must be 1). Default: 1
#       retention_unit: "days"         # (Optional) days. Default: "days"
#       retention_value: 7             # (Optional) Retention value. Default: 7
#     weekly:
#       interval: 1                    # (Optional) Day of week 1=Sunday…7=Saturday. Default: 1
#       retention_unit: "weeks"        # (Optional) weeks. Default: "weeks"
#       retention_value: 4             # (Optional) Retention value. Default: 4
#     monthly:
#       interval: 1                    # (Optional) Day of month 1-28. Default: 1
#       retention_unit: "months"       # (Optional) months. Default: "months"
#       retention_value: 12            # (Optional) Retention value. Default: 12
#     yearly:
#       interval: 1                    # (Optional) Month of year 1-12. Default: 1
#       retention_unit: "years"        # (Optional) years. Default: "years"
#       retention_value: 2             # (Optional) Retention value. Default: 2
#     export:
#       cloud_provider: "AWS"         # (Optional) Override cloud provider for this export: AWS | GCP | AZURE. Default: settings.cloud_provider
#       bucket_name: "my-s3-bucket"   # (Required for AWS) S3 bucket name for backup export
#       iam_role_id: "role-id"        # (Required for AWS) Atlas IAM role ID (assumed role) for S3 bucket access
#       service_url: ""               # (Required for GCP/AZURE) Service URL for the export bucket
#       role_id: ""                   # (Required for GCP/AZURE) Role ID for bucket access
#       frecuency_type: "DAILY"       # (Optional) HOURLY | DAILY | WEEKLY | MONTHLY | YEARLY. Default: "DAILY"
#     copy:
#       cloud_provider: "AWS"         # (Optional) Override cloud provider for copy: AWS | GCP | AZURE. Default: settings.cloud_provider
#       frequencies: []               # (Optional) Frequencies to copy. Default: []
#       region_name: "US_EAST_1"      # (Optional) Target Atlas region. Default: computed from AWS region
#       copy_oplogs: false            # (Optional) Copy oplogs. Default: false
#   global:
#     zone_name: "Zone 1"            # (Optional) Zone name for global clusters. Default: null
#   regions:
#     - backing_provider: "AWS"      # (Optional) AWS | GCP | AZURE. Default: null
#       provider: "AWS"              # (Optional) AWS | GCP | AZURE | TENANT. Default: "TENANT"
#       region: "US_EAST_1"          # (Optional) Atlas region. Default: computed from AWS region
#         # Note: AWS region (e.g. "us-east-1") is transformed to Atlas format "US_EAST_1"
#       priority: 7                  # (Optional) Electable node priority 1-7. Default: 7
#       electable:
#         size: "M10"                # (Optional) Instance size (e.g. M10, M20, M30, M40). Default: "M2"
#         count: 3                   # (Optional) Node count. Default: null
#         iops: 3000                 # (Optional) Provisioned IOPS (AWS only). Default: null
#         volume_type: "gp3"         # (Optional) EBS volume type: gp2 | gp3 | io1. Default: null
#         disk_size: 100             # (Optional) Disk size in GB. Default: null
#       analytics:
#         size: "M10"                # (Optional) Analytics instance size. Default: "M2"
#         count: 1                   # (Optional) Node count. Default: null
#         iops: 3000                 # (Optional) Provisioned IOPS (AWS only). Default: null
#         volume_type: "gp3"         # (Optional) EBS volume type. Default: null
#         disk_size: 100             # (Optional) Disk size in GB. Default: null
#       read_only:
#         size: "M10"                # (Optional) Read-only instance size. Default: "M2"
#         count: 0                   # (Optional) Node count. Default: null
#         iops: 3000                 # (Optional) Provisioned IOPS (AWS only). Default: null
#         volume_type: "gp3"         # (Optional) EBS volume type. Default: null
#         disk_size: 100             # (Optional) Disk size in GB. Default: null
#       auto_scaling:
#         disk: false                # (Optional) Enable disk auto-scaling. Default: false
#         compute: false             # (Optional) Enable compute auto-scaling. Default: false
#         max_size: "M40"            # (Optional) Maximum instance size. Default: null
#         min_size: "M10"            # (Optional) Minimum instance size. Default: null
#         scale_down: false          # (Optional) Enable scale-down. Default: false
#         analytics:
#           disk: false              # (Optional) Enable analytics disk auto-scaling. Default: false
#           compute: false           # (Optional) Enable analytics compute auto-scaling. Default: false
#           max_size: "M40"          # (Optional) Maximum analytics instance size. Default: null
#           min_size: "M10"          # (Optional) Minimum analytics instance size. Default: null
#           scale_down: false        # (Optional) Enable analytics scale-down. Default: false
#   shards:                          # (Optional) Additional shards for SHARDED/GEOSHARDED clusters. Default: []
#     - zone_name: "Zone 1"         # (Optional) Zone name for this shard (required for GEOSHARDED). Default: null
#       regions:                    # (Optional) List of region_configs for this shard. Same structure as settings.regions.
#         - provider: "AWS"
#           region: "EU_WEST_1"
#           priority: 7
#           electable:
#             size: "M30"
#             count: 3
#             disk_size: 10
#   hoop:
#     enabled: false                 # (Optional) Configure HOOP connection resource. Default: false
#     agent: "hoop-agent-name"       # (Required when enabled) HOOP agent name
#     tags: []                       # (Optional) Additional HOOP connection tags. Default: []
variable "settings" {
  description = "Settings for the MongoDB Atlas cluster and AWS integrations"
  type        = any
  default     = {}
}

variable "run_hoop" {
  description = "Run hoop with agent via null_resource local-exec. Requires HOOP CLI to be installed and authenticated on the Terraform runner."
  type        = bool
  default     = false
}
