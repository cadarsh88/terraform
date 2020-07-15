output endpoint {
  value = aws_db_instance.mysqlmultiazinstance.endpoint
}
output secondaryarn {
  value = aws_db_instance.mysqlmultiazinstance.arn
}