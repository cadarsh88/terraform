provider "aws" {
  profile = "dbcoe-sdlc-preprod"
  region  = "eu-west-1"
}

resource "aws_db_instance" "a206498-mysqlinstance" {
  identifier         = "a206498-mysqlinstance"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "adarsh"
  password             = "v6RWJR2MkzVK3e6b"
  parameter_group_name = "default.mysql5.7"
}