output "vpc_id" { 
  value       =  "${aws_vpc.main.id}"
}
output "pub_subnet_id" { 
  value       =  values(aws_subnet.public)[*].id
}

output "priv_subnet_id" {
  value       =  values(aws_subnet.private)[*].id
}

output "security_group" {
  value       =  aws_security_group.main.id
}
output "eip_public_ip" {
  description = "Contains the public IP address"
  value       = aws_eip.eip.public_ip
}