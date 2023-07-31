module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "taco_daoc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false
  create_igw = true

  create_database_subnet_group = true
  create_database_internet_gateway_route = true
}