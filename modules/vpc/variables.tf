variable "vpc_name" {
  type= string
  default = "default name"

}
variable "vpc_cidr" {
  type= string

}
variable "enable_dns_hostnames" {
  type        = bool
  default     = false
}

variable "enable_dns_support" {
  type        = bool
  default     = false
}
##################

variable "pub_cidr" {
  type = list(string)
}

variable "pub_azs" {
    type= list(string)
}
variable "priv_cidr" {
  type = list(string)
}

variable "priv_azs" {
    type= list(string)
}
####################
variable "pub_gw_destination" {
  type        = string
}
variable "priv_gw_destination" {
  type        = string
}
####################

variable "inbound" {
  type = list(object({
    protocol = string
    port = number
    cidr = list(string)
    description = string
  }))
}

variable "outbound" {
  type = list(object({
    protocol = string
    port = number
    cidr = list(string)
    description = string
  }))
}