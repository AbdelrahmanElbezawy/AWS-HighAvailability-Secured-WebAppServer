output "pub_id" {
  value = [
    for i in aws_instance.public : i.id
  ]
}
output "priv_id" {
  value = [
    for i in aws_instance.private : i.id
  ]
}