resource "aws_lb_target_group" "public_tg" {
   name               = var.public_name
   target_type        = "instance"
   port               = 80
   protocol           = "HTTP"
   vpc_id             = var.vpc_id
   health_check {
      healthy_threshold   = var.health_check["healthy_threshold"]
      interval            = var.health_check["interval"]
      unhealthy_threshold = var.health_check["unhealthy_threshold"]
      timeout             = var.health_check["timeout"]
      path                = var.health_check["path"]
      port                = var.health_check["port"]
  }
}
##########################################3
resource "aws_lb_target_group" "private_tg" {
   name               = var.private_name
   target_type        = "instance"
   port               = 80
   protocol           = "HTTP"
   vpc_id             = var.vpc_id
   health_check {
      healthy_threshold   = var.health_check["healthy_threshold"]
      interval            = var.health_check["interval"]
      unhealthy_threshold = var.health_check["unhealthy_threshold"]
      timeout             = var.health_check["timeout"]
      path                = var.health_check["path"]
      port                = var.health_check["port"]
  }
}