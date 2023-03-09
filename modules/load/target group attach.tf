#public loadbalancer

resource "aws_lb_target_group_attachment" "tg_attachment_public1" {
    target_group_arn = aws_lb_target_group.public_tg.arn
    target_id        = var.public_id[0]
    port             = 80
}

resource "aws_lb_target_group_attachment" "tg_attachment_public2" {
    target_group_arn = aws_lb_target_group.public_tg.arn
    target_id        = var.public_id[1]
    port             = 80
}
###################################
#private loadbalancer

resource "aws_lb_target_group_attachment" "tg_attachment_private1" {
    target_group_arn = aws_lb_target_group.private_tg.arn
    target_id        = var.private_id[0]
    port             = 80
}

resource "aws_lb_target_group_attachment" "tg_attachment_private2" {
    target_group_arn = aws_lb_target_group.private_tg.arn
    target_id        = var.private_id[1]
    port             = 80
}