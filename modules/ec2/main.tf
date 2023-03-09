#main
resource "aws_instance" "public" {

  for_each = {for server in local.pub_ins: server.instance_name =>  server}
  
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = each.value.instance_type
  key_name               = each.value.key_name
  vpc_security_group_ids = [each.value.security_groups]
  subnet_id              = each.value.subnet_id
/*
  user_data = <<-EOF
  #!/bin/bash
  sudo apt update -y
  sudo apt install apache2 -y
  echo  "<h1>Hello world from $(hostname -f)</h1>" > /var/www/html/index.html
  a2enmod proxy
  a2enmod proxy_http
  a2enmod proxy_balancer
  a2enmod lbmethod_byrequests
  sed '/:80>/a ProxyPreserveHost On\nProxyPass / http://${var.dns_name}\nProxyPassReverse / http://${var.dns_name}\n' /etc/apache2/sites-available/000-default.conf > /etc/apache2/sites-available/apache && mv /etc/apache2/sites-available/apache /etc/apache2/sites-available/000-default.conf
  sudo systemctl restart apache2
  EOF   
*/
  connection {
    host        = "${self.public_ip}"
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("E:/terra-form/aws_key_pair.pem")
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install apache2 -y",
      "sudo systemctl stop apache2 ",
      "sudo a2enmod rewrite",
      "sudo a2enmod proxy",
      "sudo a2enmod proxy_http",
      "sudo a2enmod proxy_balancer",
      "sudo sed '4 i ProxyPreserveHost On\n' /etc/apache2/sites-available/000-default.conf > ./l1",
      "sudo mv -f ./l1  /etc/apache2/sites-available/000-default.conf " , 
      "sudo sed '5 i ProxyPass / http://${var.dns_name}\n'    /etc/apache2/sites-available/000-default.conf > ./l1 " ,
      "sudo mv -f ./l1  /etc/apache2/sites-available/000-default.conf ",
      "sudo sed '6 i ProxyPassReverse / http://${var.dns_name}\n' /etc/apache2/sites-available/000-default.conf > ./l1",
      "sudo mv -f ./l1 /etc/apache2/sites-available/000-default.conf",
      "sudo printf '<h1>Hello world from ${self.private_ip}</h1>' > ./index.html",
      "sudo mv -f ./index.html /var/www/html/index.html",
      "sudo systemctl restart apache2",

 ]
  }



  provisioner "local-exec" {
    working_dir = "E:\\terra-form"
    command = "echo ${each.value.instance_name}  ${self.public_ip}>>myip.txt"
  }
  #  depends_on = [aws_lb.private]
  tags = {
    Name = "${each.value.instance_name}"
  }
}

resource "aws_instance" "private" {

  for_each = {for server in local.priv_ins: server.instance_name =>  server}
  
  ami                     = "${data.aws_ami.ubuntu.id}"
  instance_type           = each.value.instance_type
  key_name                = each.value.key_name
  vpc_security_group_ids  = [each.value.security_groups]
  subnet_id               = each.value.subnet_id



user_data = <<EOF
  #!/bin/bash
  sudo apt update -y
  sudo apt install -y apache2
  sudo chmod -R 755 /var/www
  sudo echo "<h1>Hello world from $(hostname -f)</h1>" > /var/www/html/index.html
  sudo systemctl start apache2
  sudo systemctl enable apache2

EOF

# /*
#     connection {
#     host        = "${aws_instance.private[1].private_ip}"
#     type        = "ssh"
#     user        = "ubuntu"
#     private_key = file("E:/terra-form/aws_key_pair.pem")
#   }
#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt update -y",
#       "sudo apt install apache2 -y",
#       "sudo service apache2 stop",
#       "sudo printf '<h1>Hello world from ${self.private_ip}</h1>' > ./index.html",
#       "sudo mv -f ./index.html /var/www/html/index.html",
#       "sudo service apache2 start",
#  ]
#   }
# */

  provisioner "local-exec" {
    working_dir = "E:\\terra-form"
    command     = "echo ${each.value.instance_name}  ${self.private_ip}>>myip.txt"
  }

  tags = {
    Name = "${each.value.instance_name}"
  }

}
