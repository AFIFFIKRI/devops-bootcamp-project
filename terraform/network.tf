module "my_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = "devops-vpc"
  cidr = "10.0.0.0/24"
  azs  = ["ap-southeast-1a"]

  # subnet value
  public_subnets  = ["10.0.0.0/25"]     
  private_subnets = ["10.0.0.128/25"]  

  # tags subnet
  public_subnet_tags  = { Name = "devops-public-subnet" }
  private_subnet_tags = { Name = "devops-private-subnet" }

  # tags internet and nat gateway
  igw_tags = { Name = "devops-igw" }
  nat_gateway_tags = { Name = "devops-ngw" }

  # tags route table
  public_route_table_tags  = { Name = "devops-public-route" }
  private_route_table_tags = { Name = "devops-private-route" }

  map_public_ip_on_launch = true
  enable_nat_gateway      = true
  single_nat_gateway      = true
}