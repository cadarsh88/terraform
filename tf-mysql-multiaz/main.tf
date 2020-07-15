provider "aws" {
  profile = "dbcoe-sdlc-preprod"
  region  = var.region
}

provider "aws" {
  alias  = "primary"
  region = var.primary_region
  profile = "dbcoe-sdlc-preprod"
}

provider "aws" {
  alias  = "secondary"
  region = var.secondary_region
  profile = "dbcoe-sdlc-preprod"
}

resource "aws_db_instance" "mysqlmultiazinstance" {
    provider = aws.primary
    identifier         = "${var.prefix}mysqlmultiazinstance"
    allocated_storage    = 20
    storage_type         = var.storage_type
    engine               = var.engine
    engine_version       = var.engine_version
    instance_class       = var.instance_class
    name                 = "mydb"
    username             = var.admin_username
    password             = var.admin_password
    parameter_group_name = var.parameter_group_name
    multi_az = var.multi_az
    port = var.port
    backup_retention_period = var.backup_retention_period
    skip_final_snapshot = true
}