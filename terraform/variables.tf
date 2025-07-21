variable "region" {
  description = ""
  type        = string  
}

variable "cluster_name" {
  description = ""
  type        = string
}

variable "vpc_cidr" {
  description = ""
  type        = string
}

variable "public_subnets" {
  description = ""
  type        = list(string)
  
}

variable "private_subnets" {
  description = ""
  type        = list(string)

}

variable "vpc_name" {
  description = ""
  type        = string
}


variable "azs" {
  description = ""
  type        = list(string)
}