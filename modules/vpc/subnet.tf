 resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    for_each = { for i, b in var.pub_cidr : b => { index = i } }
        cidr_block = var.pub_cidr[each.value.index]
        availability_zone = var.pub_azs[each.value.index]
        map_public_ip_on_launch = true

    
    depends_on = [aws_vpc.main]
    tags = {
        Name = "public-${each.value.index+1}"
    }
}
#######################################################
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.main.id
    
    for_each = { for i, b in var.priv_cidr : b => { index = i } }
        cidr_block = var.priv_cidr[each.value.index]
        availability_zone = var.priv_azs[each.value.index]
        map_public_ip_on_launch = false
    depends_on = [aws_vpc.main]
    tags = {
      Name = "private-${each.value.index+1}"
    }
}