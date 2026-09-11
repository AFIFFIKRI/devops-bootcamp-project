data "aws_ami" "my_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

data "aws_iam_instance_profile" "my_ssm_profile" {
  name = "EC2-SSM-Role"
}

# Web server (public) ----------------------------
module "web" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.0"

  name                   = "web-server"
  ami                    = data.aws_ami.my_ami.id
  instance_type          = "t3.micro"
  subnet_id              = module.my_vpc.public_subnets[0]
  private_ip             = "10.0.0.5"
  create_security_group  = false
  vpc_security_group_ids = [module.public_sg.id]
  iam_instance_profile   = data.aws_iam_instance_profile.my_ssm_profile.name

  user_data = templatefile("userdata.sh", {})
  tags      = { Name = "web-server" }
}

resource "aws_eip" "web" {
  domain   = "vpc"
  instance = module.web.id
  tags     = { Name = "web-server-eip" }
}

# Ansible controller (private) ----------------------------
module "controller" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.0"

  name                   = "ansible-controller"
  ami                    = data.aws_ami.my_ami.id
  instance_type          = "t3.micro"
  subnet_id              = module.my_vpc.private_subnets[0]
  private_ip             = "10.0.0.135"
  create_security_group  = false
  vpc_security_group_ids = [module.private_sg.id]
  iam_instance_profile   = data.aws_iam_instance_profile.my_ssm_profile.name

  user_data = templatefile("userdata.sh", {})
  tags      = { Name = "ansible-controller" }
}

# Monitoring server (private) ----------------------------
module "monitoring" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.0"

  name                   = "monitoring-server"
  ami                    = data.aws_ami.my_ami.id
  instance_type          = "t3.micro"
  subnet_id              = module.my_vpc.private_subnets[0]
  private_ip             = "10.0.0.136"
  create_security_group  = false
  vpc_security_group_ids = [module.private_sg.id]
  iam_instance_profile   = data.aws_iam_instance_profile.my_ssm_profile.name

  user_data = templatefile("userdata.sh", {})
  tags      = { Name = "monitoring-server" }
}