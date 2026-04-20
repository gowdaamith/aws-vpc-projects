data "aws_availability_zones" "available" {
  state = "available"
}

#vpc

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  

  tags = {
    Name  = "${var.project_name}-${var.environment}-vpc"
  }
}

#subnets 

resource "aws_subnet" "public" {
  count = 2
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr,8,count.index +1)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-${var.environment}-public-${count.index + 1}"
  }
}

resource "aws_subnet" "app"{
  count = 2 
  vpc_id = aws_vpc.main.id 
  cidr_block = cidrsubnet(var.vpc_cidr,8,count.index +11)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags =  {
    Name = "${var.project_name}-${var.environment}-app-${count.index + 1 }"   }
}

resource "aws_subnet" "data" {
  count = 2
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr,8,count.index + 21)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${var.project_name}-${var.environment}-data-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw"{ 
  vpc_id =aws_vpc.main.id
  tags  = {
    Name = "${var.project_name}-${var.environment}-igw"
  }
}
resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id =aws_eip.nat.id
  subnet_id = aws_subnet.public[0].id
  tags = {
    Name = "${var.project_name}-${var.environment}-nat"
  }
  depends_on = [ aws_internet_gateway.igw]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.project_name}-${var.environment}-rt-public"
  }
}

resource "aws_route_table" "app" {
  vpc_id =aws_vpc.main.id
  route {
     cidr_block = "0.0.0.0/0"
     nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags =  { Name = "${var.project_name}-${var.environment}-rt-app" }
}
resource "aws_route_table" "data" {
  vpc_id = aws_vpc.main.id
  tags = { Name = "${var.project_name}-${var.environment}-rt-data" }
}

# Route tabel association 

resource "aws_route_table_association" "public" {
  count = 2
  subnet_id  = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "app"{
  count = 2
  subnet_id =aws_subnet.app[count.index].id
  route_table_id = aws_route_table.app.id
}
resource "aws_route_table_association" "data" {
  count = 2
  subnet_id = aws_subnet.data[count.index].id
  route_table_id =aws_route_table.data.id
}

