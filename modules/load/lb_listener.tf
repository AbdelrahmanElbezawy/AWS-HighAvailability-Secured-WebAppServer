resource "aws_lb_listener" "public" {
   load_balancer_arn    = aws_lb.public.id
   port                 = "80"
   protocol             = "HTTP"
   default_action {
    target_group_arn = aws_lb_target_group.public_tg.id
    type             = "forward"
  }
}
#########################################
resource "aws_lb_listener" "private" {
   load_balancer_arn    = aws_lb.private.id
   port                 = "80"
   protocol             = "HTTP"
   default_action {
    target_group_arn = aws_lb_target_group.private_tg.id
    type             = "forward"
  }
}
