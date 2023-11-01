#

variable "ec2_id" {
}


variable "cidrs" {
  description = "Cidre blocks for VPC and Subnets"
  type        = map(string)
  default = {
    "vpc" = "10.0.0.0/16"   # Cidre for VPC
    "sn1" = "10.0.0.0/18"   # Cidre for Private Subnet
    "sn2" = "10.0.64.0/18"  # Cidre for Public Subnet 1
    "sn3" = "10.0.128.0/18" # Cidre for Public Subnet 2 

  }
}

variable "sn1_nam" {
  description = "Name for the Private Subnet"
  type        = string
  default     = "Private Sn"
}
variable "sn2_nam" {
  description = "Name for the Public Subnets"
  type        = list(string)
  default     = ["Public Sn 1", "Public Sn 2"]
}

variable "route" {
  description = "Route table id to be used by subnets"
  type        = string
  default     = "0.0.0.0/0"
}

variable "my_cidre" {
  description = "CIDR-Blocks to accept ssh from"
  type        = string
  default     = "0.0.0.0/0"
}


variable "lb_type" {
  default = "application"
  type    = string
}

variable "ports" {
  type = map(number)
  default = {
    "http"  = 80,
    "https" = 443
    "ssh"   = 22,
    "all"   = 0
  }
  sensitive = true

}

variable "protocols" {
  description = "protocols to use"
  default     = ["HTTP", -1, "tcp"]
  type        = list(any)
  sensitive   = true
}

variable "azs" {
  description = "Availability zones in which the resources will be created"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b"]
}


variable "ssm_prifix" {
  description = "Prefix name for ssm parameter names"
  default     = "/my/us-east-2/vpc"
  type        = string
}

variable "tag_prefix" {
  description = "Prefix name for tags on all resources"
  default     = "my-vpc"
  type        = string
}

variable "name_prefix" {
  description = "Prefix name for tags on all resources"
  default     = "my-vpc"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy resources into"
  type        = string
  default     = "us-east-2"
}

variable "tenancy" {
  description = "Instance tenancy option"
  type        = string
  default     = "default"
}


variable "bool_1" {
  description = "Boolean variable 1 used in conditional statement"
  type        = bool
  default     = true
}



variable "bool_2" {
  description = "Boolean variable 2 used in conditional statement"
  type        = bool
  default     = false
}

variable "lb_type" {
  description = "Type of load balancer: application or network"
  type        = string
  default     = "application"
}