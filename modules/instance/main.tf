resource "aws_security_group" "SG" {
  vpc_id = var.vpc_id
  name   = var.nameTag
  tags = {
    Name = var.nameTag
  }

dynamic "egress" {
  for_each = var.egressrules
  content {
    to_port     = egress.value.port
    from_port   = egress.value.port
    protocol    = "tcp"
    description = egress.value.description
    cidr_blocks = ["0.0.0.0/0"]
  }
}
dynamic "ingress" {
  for_each = var.ingressrules
  content {
    to_port     = ingress.value.port
    from_port   = ingress.value.port
    protocol    = "tcp"
    description = ingress.value.description
    cidr_blocks = ["0.0.0.0/0"]
  }
}
}


resource "tls_private_key" "Instance_key" {
    algorithm   = "RSA"
    rsa_bits    = 2048
  
}

resource "aws_key_pair" "keypair" {
    depends_on      = [ tls_private_key.Instance_key ]
    key_name        = "${var.nameTag}_keypair"
    public_key      = tls_private_key.Instance_key.public_key_openssh

}

resource "aws_instance" "ec2" {
  count                   = sum([for config in var.instance_config : config.count])
  depends_on              = [aws_key_pair.keypair, aws_security_group.SG]
  instance_type           = element(flatten([for config in var.instance_config : [for _ in range(config.count) : config.instance_type]]), count.index)
  ami                     = element(flatten([for config in var.instance_config : [for _ in range(config.count) : config.ami]]), count.index)
  vpc_security_group_ids  = [aws_security_group.SG.id]
  subnet_id               = var.subnet_id

  tags = {
    Name = "${var.nameTag} Instance ${count.index + 1}"
  }
}


