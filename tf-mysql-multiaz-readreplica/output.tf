output endpoint {
  value = aws_db_instance.mysqlmultiazinstancereadreplica.endpoint
}
output secondaryarn {
  value = aws_db_instance.mysqlmultiazinstancereadreplica.arn
}