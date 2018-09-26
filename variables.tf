variable "aws_ssh_admin_key_file" { }
variable "aws_secret_key" {
  description = "Please pass the aws_secret_key "
}
variable "aws_access_key" {
  description = "Please pass the aws_access_key "
}
variable "aws_subnet_id" {
  description = "Please enter the subnet id from aws account"
}
variable "aws_vpc_id" {
  description = "Please enter the vpc id from aws account"
}
variable "aws_region" {   }
variable "aws_ami" {}
variable "aws_instance_type" {}
variable "aws_ssh_private_key" {}