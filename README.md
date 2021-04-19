# Introduction

This is a Terraform skeleton repository for Terraform workshops.

# Preparations

* Install Git
* Install latest Terraform 0.14.x
* Clone this repository
    * git clone https://github.com/Puppet-Finland/terraform-workshop.git
* Make some changes to the files
    * main.tf: in *terraform* block change the *key* to match your alias/nickname
    * main.tf: in *provider* block change the *region* if Terraform tells you that the VPC limit has exceeded. By default AWS limits number of VPC to five per region.
    * variables.tf: in the *region* variable change *default* to match the above (if you changed it)
    * variables.tf: change the second number in the commented out default values of the cidr_block variables to a random value between 1 and 254, then uncomment the lines. This prevents VPC/subnet blocks created by others from overlapping yours and causing problems.

Then create $HOME/.aws/credentials (Linux, BSD, MacOS) or
%USERPROFILE%/.aws/credentials (Windows) with the following content:

    [default]
    aws_access_key_id=your-access-key-id
    aws_secret_access_key=your-secret-access-key

Now you should be able to go back to the root of the repository and initialize the Terraform root module:

    terraform init

This creates ./.terraform directory with all the plugins and metadata.

# Updating to latest version of this code

To update to latest version of this code run

    git pull

from within this repository.

# Running Terraform

To see what Terraform *would* do:

    terraform plan

To apply your configurations with Terraform:

    terraform apply

To show outputs (public IP of the webserver):

    terraform output

# Goal of the workshop

The goal is to create a web server in AWS inside a *new* VPC (Virtual Private
cloud). This is a tough challenge for a few hours of time if done from
scratch, so plenty of instructions and sample code is included.

# Terraform resources you will be using

You should be able to accomplish this task with the following Terraform resources:

* [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) (implemented)
* [aws_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) (implemented)
* [aws_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) (missing)
* [aws_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) (missing, use inline routes)
* [aws_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) (missing)
* [aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) (partially implemented)
* [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) (missing, use inline ingress and egress rules)

Installation and configuration of the web server software (nginx) is done by
passing a user_data script to the
[aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
resource using the
[template_file function](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file).
More details on user_data in AWS is available [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html).

# What needs to be implemented?

If you run the sample code you will get a VPC, two subnets and one EC2 instance (VM). However, you are not able to access the EC2 instance in any way. This is because of several reasons:

* The VPC does not have an Internet gateway. One is needed to route traffic to the Internet
* The VPC does not have a routing table with a catch-all route (0.0.0.0/0) that would enable the EC2 instance to realize that if packets are not aimed at the VPC, they should be sent to the Internet gateway.
* The routing table (above) is not associated with the VPC subnets (primary and secondary)
* No security groups are attached to the EC2 instance
* The (missing) security group(s) need to allow inbound (ingress) traffic to TCP port 80 from the anywhere (0.0.0.0/0) and outbound (egress) traffic to anywhere (0.0.0.0/0)

If you successfully implement all the code you will see a "Hello World"-style webpage at

```
http://<public-ip-of-your-instance>
```
