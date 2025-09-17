resource "aws_instance" "app_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_name

  tags = {
    Name = "${var.ecommerce}-ec2-app"
  }
}

resource "aws_instance" "bastion" {
  count                  = var.enable_bastion ? 1 : 0
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_name

  associate_public_ip_address = true

  tags = {
    Name = "${var.ecommerce}-bastion"
  }
}
