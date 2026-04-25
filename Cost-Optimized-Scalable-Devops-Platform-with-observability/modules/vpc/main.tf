variable "vpc_cidr" { } 

resource "aws_vpc" "this" {
  cidr_block  = var.vpc_cidr
  tags = {
    Name = "devops-vpc"
  }

output "vpc_id"{
  value = aws_vpc.this.id
}


