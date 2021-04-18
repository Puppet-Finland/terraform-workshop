# This variables makes it easier to select the Ubuntu 20.04 AMI for the region
# you chose. Data comes from https://cloud-images.ubuntu.com/locator/ec2/
#
variable "amis" {
  type = map(string)
  default = {
    eu-central-1 = "ami-0848da720bb07de35"
    eu-north-1   = "ami-0fec69b5d800dbc52"
    eu-south-1   = "ami-0a58fdfdee11a0855"
    eu-west-1    = "ami-09c60c18b634a5e00"
    eu-west-2    = "ami-0983862b6bc91d9f1"
    eu-west-3    = "ami-074b55365a6e960bb"
  }
}

# Make sure this matches the provider region in main.tf
variable "region" {
  description = "AWS region"
  default = "eu-central-1"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  # Change the second number (84) randomly to something else between 1 and 254, then uncomment the line.
  #default = "10.84.0.0/16"
}

variable "primary_subnet_cidr_block" {
  description = "Primary subnet CIDR block"
  # Change the second number (84) to match the value in vpc_cidr_block, then uncomment the line.
  #default = "10.84.1.0/24"
}

variable "secondary_subnet_cidr_block" {
  description = "Secondary subnet CIDR block"
  # Change the second number (84) to match the value in vpc_cidr_block, then uncomment the line.
  #default = "10.84.2.0/24"
}
