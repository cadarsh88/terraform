variable asset_id {
  type        = string
  description = "Refintiv asset ID"
  default = ""
}

variable rds_name {
  type        = string
  description = "String to contain in the RDS name"
  default = "coe"
}

variable rds_tags {
  type        = map(string)
  description = "Additional Tags to be applied to the RDS instance"
  default     = {}
}

variable "rds_ingress" {
  type = map
  default = {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
  }
}

variable rds_subnet_group_name {
  type        = string
  description = "Name of existing subnet group to use"
  default = ""
}

variable "rds_vpc_security_group_ids" {
  type = "list"
  description = "RDS List of VPC security groups to associate"
}

variable "rds_is_multi_az" {
  default     = true
  type        = bool
  description = "Specifies if the RDS instance is multi-AZ"
}

variable rds_engine {
  type        = string
  description = "Engine to use in the RDS cluster"
}

variable rds_engine_mode {
  type        = string
  description = "The database engine mode. Valid values: global, parallelquery, provisioned, serverless."
  default     = ""
}

variable rds_engine_family {
  type        = string
  description = "Engine family to use in the RDS cluster"
  default     = ""
}

variable rds_engine_version {
  type        = string
  description = "Version of the engine to use in the RDS cluster"
}

variable rds_master_username {
  type        = string
  description = "Master username for the database"
  default = "master"
}

variable rds_master_password_secret_name {
  type        = string
  description = "Name of the secret holding the rds master password. This secret must be set manually in the AWS console using AWS Secrets Manager. The secret name must start with the asset ID"
  default = ""
  }

variable "rds_allocated_storage" {
  description = "RDS allocated storage"
}

variable "rds_storage_type" {
  description = "RDS storage type"
  default = "gp2"
}

variable rds_backup_retention_period {
  type        = number
  description = "Backup retention period in days"
}

variable rds_backup_window {
  type        = string
  description = "Preferred backup window"
}

variable rds_snapshot_identifier {
  type        = string
  description = "The snapshot identifier used when restoring from backup. Default is null. Only set this value if restoring from backup"
  default     = null
}


variable rds_instance_count {
  type        = number
  description = "Amount of instances to put into the RDS cluster"
}

variable rds_instance_type {
  type        = string
  description = "Shape of the RDS instance to use"
}

variable "region" {
  description = "The AWS region"
  default     = "eu-west-1"
}

variable "primary_region" {
  description = "The AWS region"
  default     = "eu-west-1"
}

variable "secondary_region" {
  description = "The AWS region"
  default     = ""
}

variable vpc_id {
  type        = string
  description = "vpc_id"
  default = ""
}

variable database_name {
  type        = string
  description = "The name of the default database that will be created"
  default     = "SAMPLEDBCOE"
}

variable storage_encrypted {
  default     = false
  type        = bool
  description = "Specifies whether the RDS DB cluster is encrypted. The default is set to true to comply with Refinitiv standards"
}

variable skip_final_snapshot {
  default     = true
  type        = bool
  description = "whether we should skip taking a snapshot of db before destroying it"
}

variable enabled_cloudwatch_logs_exports {
  type        = list(string)
  description = "List of log types to export to cloudwatch. If omitted. The following log types are supported: audit, error, general, slowquery, postgresql (PostgreSQL)"
  default = []
}

variable "fr_application_asset_insight_id" {
  description = "To populate mandatory tr:application-asset-insight-id tag. See https://confluence.refinitiv.com/display/PCP/Standard%3A+Cloud+Service+Provider+Naming+and+Tagging+Standards"
  default = ""
}

variable "fr_environment_type" {
  description = "To populate mandatory fr:environment-type tag. See https://confluence.refinitiv.com/display/PCP/Standard%3A+Cloud+Service+Provider+Naming+and+Tagging+Standards"
}

variable "fr_resource_owner" {
  description = "To populate mandatory fr:resource-owner tag. See https://confluence.refinitiv.com/display/PCP/Standard%3A+Cloud+Service+Provider+Naming+and+Tagging+Standards"
  default = ""
}

variable rds_apply_changes_immediately {
  default     = false
  type        = bool
  description = "Specify whether any database modifications are applied immediately, or during the next maintenance window."
}

variable rds_enable_http_endpoint {
  default     = true
  type        = bool
  description = "Specify whether any database modifications are applied immediately, or during the next maintenance window."
}

variable rds_security_group_identifier {
  type        = string
  description = "The string to be appended to the name of the security group. This allows for multiple RDS instances to be created in the same AWS account"
  default     = "sg"
}

locals {
  prefix = "${var.fr_application_asset_insight_id}-${var.rds_name}"
  common_tags = {
    Terraform                         = "tf-aws-coe-rds"
    "fr:application-asset-insight-id" = var.fr_application_asset_insight_id
    "fr:environment-type"             = var.fr_environment_type
    "fr:resource-owner"               = var.fr_resource_owner
    "Name"                            = local.prefix
  }
  rds_tags = merge(var.rds_tags, local.common_tags)

  cluster_identifier      = "${local.prefix}-cluster"
  rds_instance_name       = "${local.prefix}-db-instance"
  rds_name_tag            = "${local.prefix}"
  rds_security_group_name = "${var.asset_id}-allow_tls_coe-${var.rds_security_group_identifier}"
}
