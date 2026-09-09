# --- Web server (has a public IP via Elastic IP) ---
output "web_server_public_ip" {
  value = aws_eip.web_eip.public_ip
}

output "ssm_command_web" {
  value = "aws ssm start-session --target ${module.web_server.id}"
}

# --- Ansible controller (private, no public IP) ---
output "controller_private_ip" {
  value = module.controller_server.private_ip
}

output "ssm_command_controller" {
  value = "aws ssm start-session --target ${module.controller_server.id}"
}

# --- Monitoring server (private, no public IP) ---
output "monitoring_private_ip" {
  value = module.monitoring_server.private_ip
}

output "ssm_command_monitoring" {
  value = "aws ssm start-session --target ${module.monitoring_server.id}"
}