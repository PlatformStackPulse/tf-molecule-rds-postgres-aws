output "endpoint" {
  description = "RDS connection endpoint (host:port)"
  value       = module.db_instance.endpoint
}

output "address" {
  description = "RDS hostname"
  value       = module.db_instance.address
}

output "port" {
  description = "RDS port"
  value       = module.db_instance.port
}

output "arn" {
  description = "ARN of the RDS instance"
  value       = module.db_instance.arn
}

output "id" {
  description = "ID of the RDS instance"
  value       = module.db_instance.id
}

output "db_subnet_group_name" {
  description = "Name of the DB subnet group"
  value       = module.subnet_group.name
}

output "parameter_group_name" {
  description = "Name of the parameter group"
  value       = module.parameter_group.name
}
