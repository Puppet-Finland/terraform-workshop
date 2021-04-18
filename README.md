# Introduction

This is a Terraform skeleton repository for Terraform workshops.

# Instructions

## Preparations

* Install latest Terraform 0.14.x
* Clone this repository
* Change the "key" in main.tf (see inline comments)
* If you have issues when creating the VPC, change the "region" of the AWS provider (see inline comments)
* Run "terraform init" to initialize your Terraform root module (creates ./.terraform directory)

## Running Terraform

To see what Terraform *would* do:

    terraform plan

To apply your configurations with Terraform:

    terraform apply

# Goal of the workshop

The goal is to create a web server in AWS inside a *new* VPC (Virtual Private
cloud). This is probably a tough challenge for a few hours of time.

# Terraform resources you will be using

You should be able to accomplish this task with the following Terraform resources:

* [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)
* [aws_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)
* [aws_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)
* [aws_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) (with inline routes)
* [aws_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association)
* [aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
* [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) (with inline ingress and egress rules)

Installation and configuration of the web server software (e.g. apache or nginx)
should be done by passing a user_data script to the
[aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
resource using the
[template_file function](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file).
More details on user_data in AWS is available [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html).
