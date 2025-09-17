//VPC
resource "aws_vpc" "principal" {
  cidr_block           = var.vpc_cidr               
  enable_dns_support   = true                        
  enable_dns_hostnames = true                        
  tags = {
    Name = "${var.ecommerce}-vpc"                     
  }
}

// Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.principal.id
  tags = {
    Name = "${var.ecommerce}-igw"                    
  }
}

// 2 subredes publicas, una en cada AZ
resource "aws_subnet" "publica" {
  count             = 2                             
  vpc_id            = aws_vpc.principal.id
  cidr_block        = var.subredes_publicas[count.index] 
  availability_zone = var.zonas_az[count.index]      
  map_public_ip_on_launch = true                    
  tags = {
    Name = "${var.ecommerce}-subnet-publica-${count.index + 1}"
  }
}

// 2 subredes privadas, una en cada AZ
resource "aws_subnet" "privada" {
  count             = 2
  vpc_id            = aws_vpc.principal.id
  cidr_block        = var.subredes_privadas[count.index] 
  availability_zone = var.zonas_az[count.index]
  tags = {
    Name = "${var.ecommerce}-subnet-privada-${count.index + 1}"
  }
}

// Tabla de ruteo solo para las subredes públicas
resource "aws_route_table" "publica" {
  vpc_id = aws_vpc.principal.id
  tags = {
    Name = "${var.ecommerce}-rt-publica"
  }
}

// Ruta a internet en la tabla de ruteo que permite todo el trafico 
resource "aws_route" "salida_internet" {
  route_table_id         = aws_route_table.publica.id
  destination_cidr_block = "0.0.0.0/0"                
  gateway_id             = aws_internet_gateway.igw.id
}

// Asociado subred pública con tabla de ruteo
resource "aws_route_table_association" "asociacion_publica" {
  count          = 2
  subnet_id      = aws_subnet.publica[count.index].id
  route_table_id = aws_route_table.publica.id
}
