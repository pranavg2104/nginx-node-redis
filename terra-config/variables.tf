variable "instance_type" {
  default = "t2.micro"
  description = "EC2 Instance Type"
}

variable "aws_region" {
  default = "ap-south-1"
  description = "AWS region"
}

variable "app_name" {
  default = "redis_application"
  description = "Application Name"
}