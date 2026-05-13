
data "aws_ami" "latest" {
  most_recent = "true"
  owners = ["amazon"]

  filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "redis_security_group" {
  vpc_id = data.aws_vpc.default.id

  ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access"
  }
  ingress{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP access"
  }

  tags = {
    Name = "${var.app_name}-sg"
  }
}

resource "aws_instance" "redis_ec2" {
  ami = data.aws_ami.latest.id

  vpc_security_group_ids = [ aws_security_group.redis_security_group.id ]
  instance_type = var.instance_type

  user_data = <<-EOF
  #!bin/bash
  apt-get update -y
  apt-get install -y docker.io docker-compose git
  systemctl start docker
  systemctl enable docker
  git clone https://github.com/pranavg2104/nginx-node-redis.git
  cd ./nginx-node-redis
  docker-compose -f compose.yml up -d --build
  EOF

  tags = {
    Name = "${var.app_name}-ec2"
  }
}