resource "aws_security_group" "main" {
  
  vpc_id = aws_vpc.main.id

  dynamic "ingress" {
  for_each = var.inbound

  content {
    from_port   = ingress.value.port
    to_port     = ingress.value.port
    protocol    = ingress.value.protocol
    cidr_blocks = ingress.value.cidr
    description = ingress.value.description
  }
}
  dynamic "egress" {
  for_each = var.outbound

  content {
    from_port   = egress.value.port
    to_port     = egress.value.port
    protocol    = egress.value.protocol
    cidr_blocks = egress.value.cidr
    description = egress.value.description

  }
}

  depends_on = [aws_vpc.main]
  tags ={
  Name = "${var.vpc_name}-SG" ,
   name = "${var.vpc_name}-SG" 

}
}