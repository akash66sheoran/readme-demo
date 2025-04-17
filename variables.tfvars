vpc_id = "vpc-0e2e6b5c94514a787"
environment = "dev"
maintainedBy = "Mavericks"
application = "Metrics server"
sg_name = "metrics-server-sg"
iam_instance_profile = "metrics-server-profile"
ec2_role_name = "metrics-server-role"

sg_inbound_rules = {
  allow_ssh = {
      source   = "0.0.0.0/0"
      from_port   = 22
      ip_protocol = "tcp"
      to_port     = 22
  }
  allow_http = {
      source   = "0.0.0.0/0"
      from_port   = 80
      ip_protocol = "tcp"
      to_port     = 80
  }
}

instances = {
  server1 = {
    ami = "ami-00a929b66ed6e0de6"
    instance_type = "t2.micro"
    key_name = "linux-key"
    subnet_id = "subnet-0e63f62a834b0b60b"
    root_block_device = {
      volume_size = 10
      volume_type = "gp3"
    }
    tags = { project = "TOD"}
  }
}

managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]