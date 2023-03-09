module "vpc" {
  source = "./modules/vpc"

  vpc_name             = "iti-vpc"
  vpc_cidr             = "10.0.0.0/16"
  enable_dns_hostnames = false
  enable_dns_support   = true

  pub_cidr = ["10.0.0.0/24", "10.0.2.0/24"]
  pub_azs  = ["us-east-1a", "us-east-1d"]

  priv_cidr = ["10.0.1.0/24", "10.0.3.0/24"]
  priv_azs  = ["us-east-1a", "us-east-1d"]

  pub_gw_destination  = "0.0.0.0/0"
  priv_gw_destination = "0.0.0.0/0"


  inbound = [
    {
      protocol    = "tcp"
      port        = 22
      cidr        = ["0.0.0.0/0"]
      description = "open ssh"
    },
    {
      protocol    = "tcp"
      port        = 80
      cidr        = ["0.0.0.0/0"]
      description = "open http"
    },
    {
      protocol    = "tcp"
      port        = 443
      cidr        = ["0.0.0.0/0"]
      description = "open https"
    }
  ]
  outbound = [
    {
      protocol    = "-1"
      port        = 0
      cidr        = ["0.0.0.0/0"]
      description = "allow all"
    }
  ]
}
module "pub_ec2" {
  source = "./modules/ec2"

  dns_name = module.pub-load.dns_name

  public_mod = [
    {
      "name" : "public0"
      "no_of_instances" : "1"
      "inst_type" : "t2.micro"
      "key_name" : "aws_key_pair"
      "subnet_id" : "${module.vpc.pub_subnet_id[0]}"
      "security_groups" : "${module.vpc.security_group}"

    },
    {
      "name" : "public1",
      "inst_type" : "t2.micro",
      "no_of_instances" : "1",
      "key_name" : "aws_key_pair",
      "subnet_id" : "${module.vpc.pub_subnet_id[1]}",
      "security_groups" : "${module.vpc.security_group}"
    }
  ]

  private_mod = [
    {
      "name" : "private0",
      "inst_type" : "t2.micro",
      "no_of_instances" : "1",
      "key_name" : "aws_key_pair",
      "subnet_id" : "${module.vpc.priv_subnet_id[0]} ",
      "security_groups" : "${module.vpc.security_group}"
    },

    {
      "name" : "private1",
      "inst_type" : "t2.micro",
      "no_of_instances" : "1",
      "key_name" : "aws_key_pair",
      "subnet_id" : "${module.vpc.priv_subnet_id[1]} ",
      "security_groups" : "${module.vpc.security_group}"
    }
  ]
}
module "pub-load" {

  source = "./modules/load"

  vpc_id       = module.vpc.vpc_id
  security_grp = ["${module.vpc.security_group}"]

  public_name = "public"
  subnets     = [for subnet in module.vpc.pub_subnet_id : subnet]
  public_id   = [for i in module.pub_ec2.pub_id : i]

  private_name = "private"
  priv_subnets = [for subnet in module.vpc.priv_subnet_id : subnet]
  private_id   = [for i in module.pub_ec2.priv_id : i]

}
#module "s3" {
#  source = "./modules/remote_state"
#
#  table_name  = "baucket9090900"
#  bucket_name = "tf_reomte_state"
#  vpc_id      = module.vpc.vpc_id
#}