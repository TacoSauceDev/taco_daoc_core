module "db" {
  depends_on = [ module.db_service_sg ]
  source = "terraform-aws-modules/rds/aws"
  version = "6.1.0"
  identifier = "tacodaoc-dev"

  engine            = "mariadb"
  engine_version    = "10.6"
  instance_class    = "db.t4g.micro"
  allocated_storage = 5

  db_name  = "taco_daoc"
  username = "taco_root"
  port     = "3306"
  publicly_accessible = true
  iam_database_authentication_enabled = false

  vpc_security_group_ids = [module.db_service_sg.security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = ["subnet-042bbb5370de6ce50", "subnet-0088dc4f300841a51"]

  # DB parameter group
  family = "mariadb10.6"

  # DB option group
  major_engine_version = "10.6"

  # Database Deletion Protection
  deletion_protection = true

  parameters = [
    {
      name  = "require_secure_transport"
      value = "0"
    }
  ]
}
module "db_service_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"
  name        = "taco_daoc_db"
  description = "Security group for access to databse from external."
  vpc_id      = "vpc-094d5373028b1a5ef"
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "DB Access Ports"
      cidr_blocks = var.INBOUND_CIDR
    }
  ]
}