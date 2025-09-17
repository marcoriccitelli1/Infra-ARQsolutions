output "app_instance_id" {
  value = aws_instance.app_server.id
}

output "app_private_ip" {
  value = aws_instance.app_server.private_ip
}

output "bastion_public_ip" {
  value = var.enable_bastion ? aws_instance.bastion[0].public_ip : null
}

