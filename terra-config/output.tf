output "public_ip" {
  value = aws_instance.redis_ec2.public_ip
  description = "EC2 Public IP"
}