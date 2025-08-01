resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

## this two parameters are required by EKS to work 

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.env}-main"
  }
}
