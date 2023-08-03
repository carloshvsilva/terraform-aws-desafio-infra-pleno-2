

provider "aws" {
  region  = "sa-east-1"
  profile = "tr-teste"
}

resource "aws_vpc" "vpc_desafio" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    "Name" = "VPC_DESAFIO"
  }
}

resource "aws_internet_gateway" "igw_desafio" {
  vpc_id = aws_vpc.vpc_desafio.id
}

resource "aws_route_table" "router_desafio" {
  vpc_id = aws_vpc.vpc_desafio.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_desafio.id
  }
  
}

resource "aws_subnet" "subnet_desafio_a" {
  vpc_id     = aws_vpc.vpc_desafio.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "sa-east-1a"
  tags = {
    "Name" = "SUBNET_DESAFIO_A"
  }
}

resource "aws_route_table_association" "assoc_a" {
  subnet_id = aws_subnet.subnet_desafio_a.id
  route_table_id = aws_route_table.router_desafio.id
}

resource "aws_subnet" "subnet_desafio_b" {
  vpc_id     = aws_vpc.vpc_desafio.id
  cidr_block = "10.0.16.0/24"
  availability_zone = "sa-east-1b"
  tags = {
    "Name" = "SUBNET_DESAFIO_B"
  }
}

resource "aws_route_table_association" "assoc_b" {
  subnet_id = aws_subnet.subnet_desafio_b.id
  route_table_id = aws_route_table.router_desafio.id
}

resource "aws_subnet" "subnet_desafio_c" {
  vpc_id     = aws_vpc.vpc_desafio.id
  cidr_block = "10.0.32.0/24"
  availability_zone = "sa-east-1c"
  map_public_ip_on_launch = "true"
  tags = {
    "Name" = "SUBNET_DESAFIO_C"
  }
}

resource "aws_route_table_association" "assoc_c" {
  subnet_id = aws_subnet.subnet_desafio_c.id
  route_table_id = aws_route_table.router_desafio.id
}

resource "aws_security_group" "sg_tudo_habilitado" {
  name        = "sg_tudo_habilitado"
  description = "Habilita qualquer tipo de conexao"
  vpc_id      = aws_vpc.vpc_desafio.id

  ingress {
    description      = "Libera tudo"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TUDO HABILITADO"
  }
}

data "template_file" "script_template" {
  template = file("${path.module}/scripts/ubuntu.sh")
}



resource "aws_instance" "instance_desafio" {
  ami = "ami-0af6e9042ea5a4e3e"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet_desafio_c.id
  vpc_security_group_ids = tolist([aws_security_group.sg_tudo_habilitado.id])
  user_data = data.template_file.script_template.rendered    
}

output "ip_publico" {
  description = "IP para abrir aplicação"
  value       = aws_instance.instance_desafio.public_ip
}

##### Criar VPC 10.0.0.0/16
##### Criar Gateway de internet
    ### Associar a VPC
##### Criar tabela de rota
    ### Configurar destino 0.0.0.0/0 para alvo (gateway de internet)
##### Criar sub rede para as 3 zd
    ### Associar a VPC 
#### Criar grupo de segurança
    ### incluir parametros de segurança 
        ### entrada
        ### saida
#### Criar interface de rede
    ### Associar com grupo de segurança
#### Na criação da máquina virtual associar VPC e subrede
    ### Ver para ativar DNS elastico publico