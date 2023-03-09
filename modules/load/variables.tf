variable "public_name" {
   type = string
}

variable "private_name" {
   type = string
}


variable "health_check" {
   type = map(string)
   default = {
      "timeout"  = "10"
      "interval" = "20"
      "path"     = "/"
      "port"     = "80"
      "unhealthy_threshold" = "2"
      "healthy_threshold" = "3"
    }
}
variable "security_grp" {
    type = list
}

variable "vpc_id"{
    type = string
}
variable "subnets" {
    type = list
    default = [null]
}
variable "public_id" {
  default = null
}

variable "priv_subnets"{
  type = list
  default = [null]
}
variable "private_id" {
  default = null
}