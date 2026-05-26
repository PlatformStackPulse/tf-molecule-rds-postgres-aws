module "subnet_group" {
  source = "git::https://github.com/PlatformStackPulse/tf-atom-db-subnet-group-aws.git?ref=v1.1.0"

  enabled   = module.this.enabled
  namespace = var.namespace
  name      = var.name
  stage     = var.stage
  tags      = var.tags

  subnet_ids = var.subnet_ids
}

module "parameter_group" {
  source = "git::https://github.com/PlatformStackPulse/tf-atom-db-parameter-group-aws.git?ref=v1.1.0"

  enabled   = module.this.enabled
  namespace = var.namespace
  name      = var.name
  stage     = var.stage
  tags      = var.tags

  family     = var.parameter_group_family
  parameters = var.parameters
}

module "db_instance" {
  source = "git::https://github.com/PlatformStackPulse/tf-atom-db-instance-aws.git?ref=v1.1.0"

  enabled   = module.this.enabled
  namespace = var.namespace
  name      = var.name
  stage     = var.stage
  tags      = var.tags

  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = true

  db_name  = var.db_name
  username = var.username
  password = var.password
  port     = var.port

  multi_az               = var.multi_az
  db_subnet_group_name   = module.subnet_group.name
  vpc_security_group_ids = var.vpc_security_group_ids
  publicly_accessible    = false
  parameter_group_name   = module.parameter_group.name

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  skip_final_snapshot          = var.skip_final_snapshot
  deletion_protection          = var.deletion_protection
  performance_insights_enabled = var.performance_insights_enabled
  auto_minor_version_upgrade   = true
  apply_immediately            = var.apply_immediately
}
