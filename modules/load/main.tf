resource "aws_lb" "public" {
    name               = var.public_name
    internal           = false
    load_balancer_type = "application" 
    security_groups    = var.security_grp
    subnets            = var.subnets
    enable_cross_zone_load_balancing = "true"

}

############################
resource "aws_lb" "private" {
    name               = var.private_name
    internal           = true
    load_balancer_type = "application" 
    security_groups    = var.security_grp
    subnets            = var.priv_subnets
    enable_cross_zone_load_balancing = "true"
}