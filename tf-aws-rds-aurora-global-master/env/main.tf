
data "aws_secretsmanager_secret" "rds_master_password" {
  name = ""
}

data "aws_secretsmanager_secret_version" "rds_master_password" {
  secret_id = data.aws_secretsmanager_secret.rds_master_password.id
}


//  Enter the AWS account ID in the allowed_account_ids and profile name to use to connect and launch resources
provider "aws" {
    region = "${var.region}"     
    profile = ""
    allowed_account_ids = []  
}

provider "aws" {
  alias  = "primary"
  region = "${var.primary_region}" 
  profile = ""
  allowed_account_ids = []
}

provider "aws" {
  alias  = "secondary"
  region = "${var.secondary_region}" 
  profile = ""
  allowed_account_ids = []
}

resource "aws_rds_global_cluster" "rds_global_cluster" {
  provider = "aws.primary"

  global_cluster_identifier = "${local.cluster_identifier}-global"
  storage_encrypted               = var.storage_encrypted
  engine                          = var.rds_engine
  engine_version                  = "${var.rds_engine_version}"
  database_name                   = var.database_name
 }

resource "aws_rds_cluster" "rds_cluster_primary" {
  provider                        = "aws.primary"
  cluster_identifier              = local.cluster_identifier
  global_cluster_identifier       = "${aws_rds_global_cluster.rds_global_cluster.id}"
  engine                          = var.rds_engine
  engine_mode                     = var.rds_engine_mode
  engine_version                  = "${var.rds_engine_version}"  
  vpc_security_group_ids          = var.rds_vpc_security_group_ids
  db_subnet_group_name            = var.rds_subnet_group_name
  database_name                   = var.database_name
  master_username                 = var.rds_master_username
  master_password                 = data.aws_secretsmanager_secret_version.rds_master_password.secret_string
  backup_retention_period         = var.rds_backup_retention_period
  preferred_backup_window         = var.rds_backup_window
  skip_final_snapshot             = var.skip_final_snapshot
  final_snapshot_identifier       = "${local.prefix}-final-snapshot-${uuid()}"
  apply_immediately               = var.rds_apply_changes_immediately
  enable_http_endpoint            = var.rds_enable_http_endpoint
  storage_encrypted               = var.storage_encrypted
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  
  tags = local.rds_tags

  # spin up the database first time round, then will ignore any changes for subsequent runs
  # This is required because other databases may be created via other operations
  # and we do not want this Terraform to think it needs to destroy them to maintain it's state
  lifecycle {
    ignore_changes = [
      database_name,
    ]
  }
  snapshot_identifier = var.rds_snapshot_identifier 
}


resource "aws_rds_cluster_instance" "rds_instance_primary" {
  provider           = "aws.primary"
  count              = var.rds_instance_count
  identifier         = "${local.rds_instance_name}-node1"
  cluster_identifier = aws_rds_cluster.rds_cluster_primary.id
  instance_class     = var.rds_instance_type
  engine             = var.rds_engine
  engine_version       = "${var.rds_engine_version}"
  apply_immediately  = var.rds_apply_changes_immediately
    
  tags = local.rds_tags
}

// Global Database Secondary Region
resource "aws_rds_cluster" "rds_cluster_secondary" {
  depends_on                      = ["aws_rds_cluster_instance.rds_instance_primary"]
  provider                        = "aws.secondary"
  cluster_identifier              = local.cluster_identifier
  global_cluster_identifier       = "${aws_rds_global_cluster.rds_global_cluster.id}"
  engine                          = var.rds_engine
  engine_version                  = "${var.rds_engine_version}"
  engine_mode                     = var.rds_engine_mode  
  vpc_security_group_ids          = []
  db_subnet_group_name            = ""
  backup_retention_period         = var.rds_backup_retention_period
  preferred_backup_window         = var.rds_backup_window
  skip_final_snapshot             = var.skip_final_snapshot
  final_snapshot_identifier       = "${local.prefix}-final-snapshot-${uuid()}"
  apply_immediately               = var.rds_apply_changes_immediately
  enable_http_endpoint            = var.rds_enable_http_endpoint
  storage_encrypted               = var.storage_encrypted
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  
  tags = local.rds_tags

  # spin up the database first time round, then will ignore any changes for subsequent runs
  # This is required because other databases may be created via other operations
  # and we do not want this Terraform to think it needs to destroy them to maintain it's state
  lifecycle {
    ignore_changes = [
      database_name,
    ]
  }
  snapshot_identifier = var.rds_snapshot_identifier 
}

resource "aws_rds_cluster_instance" "rds_instance_secondary" {
  provider           = "aws.secondary"
  count              = var.rds_instance_count
  identifier         = "${local.rds_instance_name}-node2"
  cluster_identifier = aws_rds_cluster.rds_cluster_secondary.id
  instance_class     = var.rds_instance_type
  engine             = var.rds_engine
  engine_version       = "${var.rds_engine_version}"
  apply_immediately  = var.rds_apply_changes_immediately
    
  tags = local.rds_tags
}

