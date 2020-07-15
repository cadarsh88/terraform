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
  default     = "ap-south-1"
}

variable "storage_type" {
    type = string
    default = "gp2"
    description = "Defines Storage type"
}

variable "engine"{
    type = string
    default = "mysql"
    description = "DB Engine - Can be MariaDB/MySQL"
}

variable "engine_version"{
    type = string
    default = "5.7"
    description = "DB Engine Version - Latest 8.0.19"
}

variable "instance_class"{
    type = string
    default = "db.m5.xlarge"
    description = "DB Instance Class - Standard Class(m series)"
}

variable "admin_username"{
    type = string
    description = "Administrator user name for RDS DB Instance"
    default = "admin"
}

variable "admin_password"{
    type = string
    default = "v6RWJR2MkzVK3e6b"
    description = "Administrator User's Password. Must meet AWS complexity requirements"
}

variable "parameter_group_name"{
    type = string
    default = "default.mysql5.7"
    description = "Database Parameter Group Name"
}

variable "backup_retention_period"{
    type = number
    default = 2
    description = "Database Instance Snapshot's Backup retention Period"
}

variable "multi_az"{
    type = bool
    default = true
    description = "Database MultiAZ flag"
}

variable "port"{
    type = number
    default = 3306
    description = "Database Instance Default port"
}

variable "prefix"{
    type = string
    default = "a206498-coe-"
}

variable "tags"{
    type = map(string)

    default = {
        Environment = "TerraformTest"
        Dept = "Database COE"
    }
}

variable "sku"{
    default = {
        eu-west-1 = "8.0.15"
    }
}