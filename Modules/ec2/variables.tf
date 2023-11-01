variable "type" {
  default     = "t2.micro"
  description = "instance type"
  type        = string
}

variable "instance_sg" {}

variable "ec2_subnet_id" {}

variable "ec2_name" {
  default = "My VPC Server"
  type    = string
}

variable "bool_2" {
  default = false
  type    = bool

}

variable "region" {
  default = "us-east-2"
  type    = string
}

variable "keyname" {
  description = "Name of key pair to use for ssh"
  type        = string
  default     = "Linux_machine"
}
