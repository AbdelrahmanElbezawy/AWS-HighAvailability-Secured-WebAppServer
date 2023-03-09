
#vpc
resource "aws_vpc" "main" {

      cidr_block = var.vpc_cidr
      enable_dns_support = var.enable_dns_support
      enable_dns_hostnames  = var.enable_dns_hostnames

      tags ={ 
        Name= "${var.vpc_name}"
      }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {

  vpc_id = aws_vpc.main.id
      tags ={ 
        Name= "${var.vpc_name}-GW"
      }
}
##################################################################################
# Elastic IP 
#################################################################################
resource "aws_eip" "eip" {

  vpc        = true # making it possible that a re-created VPC uses the same IPs.
  depends_on = [aws_internet_gateway.main]
  tags = {
 Name = "${var.vpc_name}_eip" 
  }
}
################################################################################
# NAT gateway 
################################################################################
resource "aws_nat_gateway" "ngw"  {
  allocation_id = aws_eip.eip.id
#  subnet_id     = aws_subnet.public.id
  subnet_id     = aws_subnet.public[element(keys(aws_subnet.public), 0)].id
  depends_on = [aws_internet_gateway.main]
  tags = {
   Name = "${var.vpc_name}_NGW" 
  }

}