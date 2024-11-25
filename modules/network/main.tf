data "aws_availability_zones" "available" {}

resource "aws_vpc" "tf_vpc" {
    cidr_block              = var.network_config.cidr_block
    enable_dns_hostnames    = var.network_config.dns_hostname
    enable_dns_support      = var.network_config.dns_support
    tags = {
      Name = "${var.global_provision_tag} VPC"
    }
}
resource "aws_subnet" "Tf_subnet" {
    vpc_id                  = aws_vpc.tf_vpc.id
    cidr_block              = var.network_config.work_subnet
    map_public_ip_on_launch = true
    availability_zone       = data.aws_availability_zones.available.names[0]
    tags = {
      Name                  = "${var.global_provision_tag} working subnet"
    }
  
}
resource "aws_internet_gateway" "tf_IG" {
    vpc_id      = aws_vpc.tf_vpc.id
    tags = {
      Name      = "${var.global_provision_tag} IG"
    }
}
resource "aws_route_table" "tf_rt" {
    vpc_id          = aws_vpc.tf_vpc.id
    route{
        cidr_block  = "0.0.0.0/0"
        gateway_id  = aws_internet_gateway.tf_IG.id
    }
    tags = {
      Name          = "${var.global_provision_tag} IG"
    }
}
resource "aws_route_table_association" "tf_rta" {
    subnet_id       = aws_subnet.Tf_subnet.id
    route_table_id  = aws_route_table.tf_rt.id
}

