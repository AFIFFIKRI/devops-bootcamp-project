output "web_server_public_ip" {
  value = aws_eip.web.public_ip   # also renamed from web_eip → web
}

output "ssm_command_web" {
  value = "aws ssm start-session --target ${module.web.id}"
}

output "controller_private_ip" {
  value = module.controller.private_ip
}

output "ssm_command_controller" {
  value = "aws ssm start-session --target ${module.controller.id}"
}

output "monitoring_private_ip" {
  value = module.monitoring.private_ip
}

output "ssm_command_monitoring" {
  value = "aws ssm start-session --target ${module.monitoring.id}"
}