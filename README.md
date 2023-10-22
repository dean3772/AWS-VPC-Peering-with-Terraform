# AWS VPC Peering with Terraform

## Description

This repository contains Terraform code to set up a VPC Peering connection between two AWS regions (`us-east-1` and `us-west-2`). It also deploys an EC2 instance in each VPC, both of which can ping each other. Access to these EC2 instances is limited to AWS Systems Manager (SSM).

## Main Objectives

* Deploy EC2 instances in two different AWS regions.
* Enable VPC Peering between these regions.
* Only allow instance access through AWS SSM.

## CI/CD

* in which a merge to the mainbranch triggers a deployment of the infrastructure to AWS account,using secrets from within that repository and github actions.

## Pre-requisites

* AWS account
* AWS CLI configured
* Terraform installed

## How To Deploy

1. **Initialize Terraform**

   terraform init
2. **Apply Changes**

   terraform apply
3. **Confirm Deployment**

   Check your AWS Console to verify that the EC2 instances have been created and the VPCs are peered

## Security

Security groups have been configured to allow ICMP traffic (ping) between the peered VPCs and also allow SSM traffic.

## Documentation

In-line comments in the Terraform code describe the purpose and function of each resource.

## Testing the Connectivity Between the 2 Regions' VPCs

To confirm that your VPCs in both regions are connected:

1. Use AWS SSM to start a session with an EC2 instance in one of the VPCs.
2. Run a `ping` command to the IP address of an EC2 instance located in the other VPC.

Example:

ping `<IP address of target EC2 instance>`

## screenshots are provided in "screenshoots" folder

after screenshots secrets were removed for security reasons.
