resource "aws_instance" "core-service"{
   ami=data.aws_ami.ubuntu.id
   instance_type=var.instance_type
   profile="production"
   tags={
     Name="core-service"
     Enviroment=var.aws_enviroment
   }
   subnet_id=aws_subnet.app_subnet.id
   associate_public_ip_address=true   

}
resource "aws_instance" "submission-service"{
   ami=data.aws_ami.ubuntu.id
   profile="production"
   instance_type=var.instance_type
   tags={
     Name="submission-service"
     Enviroment=var.aws_enviroment
   }
   subnet_id=aws_subnet.app_subnet.id
   associate_public_ip_address=true 
}

resource "aws_vpc" "app_vpc"{
  cidr_block="10.0.0.0/16"
  tags = {
    Name = "hii-coder-vpc"
  }
}


resource "aws_subnet" "app_subnet"{
 vpc_id=aws_vpc.app_vpc.id
 cidr_block="10.0.1.0/24"
 map_public_ip_on_launch = true

  tags = {
    Name = "hii-coder-public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name = "hii-coder-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "hii-coder-public-route-table"
  }
}
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "core_service" {
  name   = "core-service-sg"
  vpc_id = aws_vpc.app_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["223.185.19.84/32"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "core-service-sg"
  }
}
