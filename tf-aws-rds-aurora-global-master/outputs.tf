output endpoint {
  value = aws_rds_cluster.rds_cluster_primary.endpoint
}

output rds_instances {
  value = aws_rds_cluster_instance.rds_instance_primary[*]
}

output database_name {
  value = aws_rds_cluster.rds_cluster_primary.database_name
}