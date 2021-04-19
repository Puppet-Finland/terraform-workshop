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

To show all resources currently managed by Terraform and their attributes:

    terraform show

To destroy the infrastructure when you're done with it:

    terraform destroy

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

# Known issues

* Creating the aws_instance may fail in some regions, probably due to incompatible default values for the aws_instance. This problem has not been looked into in depth.
* Modifying routing tables seems to fail. Use "terraform destroy" followed by "terraform apply" to resolve the problem. The proper solution would be to add an IAM permission to the policy.

# Running the workshop code on your own AWS account

If you want to run this workshop's code on your own AWS account you need two things:

* Credit card (for the AWS account)
* AWS account

Once you have your AWS account ready you need to:

* Go to the IAM service
    * Create a new IAM policy (e.g. "terraform") with contents from the example below
    * Create an IAM user (e.g. "terraform") with (at minimum) programmatic access
    * Create an API keypair for the user
* In main.tf: comment out the S3 backend in main.tf and uncomment the local backend
* Run "terraform init" again to initialize the local backend

If you want more challenge set up a S3 bucket for state file storage and modify
the example IAM policy to point to the correct S3 bucket.

## Example IAM policy

Here's a sample IAM policy you can use to run the workshop. If you use a
[local state file backend](https://www.terraform.io/docs/language/settings/backends/local.html)
you can skip the S3 section at the bottom. If you *do* use the
[S3 backend](https://www.terraform.io/docs/language/settings/backends/s3.html) then
you need to modify the bucket name to match your S3 bucket.

    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "VisualEditor0",
                "Effect": "Allow",
                "Action": [
                    "ec2:AllocateAddress",
                    "ec2:AssociateAddress",
                    "ec2:AssociateRouteTable",
                    "ec2:AttachInternetGateway",
                    "ec2:AttachVolume",
                    "ec2:AuthorizeSecurityGroupEgress",
                    "ec2:AuthorizeSecurityGroupIngress",
                    "ec2:CopyImage",
                    "ec2:CreateImage",
                    "ec2:CreateInternetGateway",
                    "ec2:CreateKeyPair",
                    "ec2:CreateNetworkInterface",
                    "ec2:CreateRoute",
                    "ec2:CreateRouteTable",
                    "ec2:CreateSecurityGroup",
                    "ec2:CreateSnapshot",
                    "ec2:CreateSubnet",
                    "ec2:CreateTags",
                    "ec2:CreateVolume",
                    "ec2:CreateVpc",
                    "ec2:DeleteInternetGateway",
                    "ec2:DeleteKeyPair",
                    "ec2:DeleteNetworkInterface",
                    "ec2:DeleteRouteTable",
                    "ec2:DeleteSecurityGroup",
                    "ec2:DeleteSnapshot",
                    "ec2:DeleteSubnet",
                    "ec2:DeleteTags",
                    "ec2:DeleteVolume",
                    "ec2:DeleteVpc",
                    "ec2:DeregisterImage",
                    "ec2:DescribeAccountAttributes",
                    "ec2:DescribeAddresses",
                    "ec2:DescribeIamInstanceProfileAssociations",
                    "ec2:DescribeImageAttribute",
                    "ec2:DescribeImages",
                    "ec2:DescribeInstanceAttribute",
                    "ec2:DescribeInstanceCreditSpecifications",
                    "ec2:DescribeInstances",
                    "ec2:DescribeInstances",
                    "ec2:DescribeInternetGateways",
                    "ec2:DescribeKeyPairs",
                    "ec2:DescribeNetworkAcls",
                    "ec2:DescribeNetworkInterfaces",
                    "ec2:DescribeRegions",
                    "ec2:DescribeRouteTables",
                    "ec2:DescribeSecurityGroupReferences",
                    "ec2:DescribeSecurityGroups",
                    "ec2:DescribeSnapshots",
                    "ec2:DescribeStaleSecurityGroups",
                    "ec2:DescribeSubnets",
                    "ec2:DescribeTags",
                    "ec2:DescribeVolumes",
                    "ec2:DescribeVolumes",
                    "ec2:DescribeVpcAttribute",
                    "ec2:DescribeVpcClassicLink",
                    "ec2:DescribeVpcClassicLinkDnsSupport",
                    "ec2:DescribeVpcPeeringConnections",
                    "ec2:DescribeVpcs",
                    "ec2:DetachInternetGateway",
                    "ec2:DetachVolume",
                    "ec2:DisassociateAddress",
                    "ec2:DisassociateRouteTable",
                    "ec2:GetPasswordData",
                    "ec2:ImportKeyPair",
                    "ec2:ModifyImageAttribute",
                    "ec2:ModifyInstanceAttribute",
                    "ec2:ModifyNetworkInterfaceAttribute",
                    "ec2:ModifySnapshotAttribute",
                    "ec2:ModifySubnetAttribute",
                    "ec2:ModifyVpcAttribute",
                    "ec2:RebootInstances",
                    "ec2:RegisterImage",
                    "ec2:ReplaceIamInstanceProfileAssociation",
                    "ec2:RevokeSecurityGroupEgress",
                    "ec2:RevokeSecurityGroupIngress",
                    "ec2:RunInstances",
                    "ec2:StartInstances",
                    "ec2:StartInstances",
                    "ec2:StopInstances",
                    "ec2:TerminateInstances",
                    "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
                    "ec2:UpdateSecurityGroupRuleDescriptionsIngress"
                ],
                "Resource": "*"
            },
            {
                "Sid": "VisualEditor1",
                "Effect": "Allow",
                "Action": [
                    "s3:PutObject",
                    "s3:GetObject",
                    "s3:ListBucket"
                ],
                "Resource": [
                    "arn:aws:s3:::terraform-state-test-aws.puppeteers.net",
                    "arn:aws:s3:::terraform-state-test-aws.puppeteers.net/*"
                ]
            }
        ]
    }
