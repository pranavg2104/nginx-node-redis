resource "aws_ecr_repository" "nginx_app" {
  name = "nginx-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}