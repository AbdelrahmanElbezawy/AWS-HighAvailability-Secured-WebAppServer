resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = var.pub_gw_destination
    gateway_id = aws_internet_gateway.main.id
  }

  tags ={
    Name = "${var.vpc_name}-public"
  }
}

resource "aws_route_table_association" "public" {
  for_each = { for i, b in var.pub_cidr : b => { index = i } }
  subnet_id     = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}

######################################################
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = var.priv_gw_destination
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags ={
    Name = "${var.vpc_name}-private"
  }
}

resource "aws_route_table_association" "private" {
  for_each = { for i, b in var.priv_cidr : b => { index = i } }
  subnet_id     = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private.id
}
