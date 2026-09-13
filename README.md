# DevOps Bootcamp — Final Project

A full-stack DevOps pipeline: infrastructure provisioned with Terraform, configured with Ansible, running a containerized app with a monitoring stack exposed securely via Cloudflare Tunnel.

## 🔗 Live Links

| | URL |
|---|---|
| **Application** | https://web.servobitservices.com |
| **Monitoring (Grafana)** | https://monitoring.servobitservices.com |
| **Repository** | https://github.com/AFIFFIKRI/devops-bootcamp-project |

## 🏗️ Architecture

- **AWS VPC** (`10.0.0.0/24`) with public + private subnets, IGW, NAT Gateway
- **3 EC2 instances**, access via AWS Systems Manager only (no SSH from the internet):
  - `web-server` (public, Elastic IP) — runs the app container on port 80
  - `ansible-controller` (private) — runs all configuration
  - `monitoring-server` (private) — runs Prometheus, Grafana, cloudflared
- **ECR** — private Docker registry for the app image
- **Ansible** — installs Docker, deploys the app, sets up the monitoring stack
- **Cloudflare Tunnel** — exposes Grafana without opening any inbound ports

## 📁 Repo Structure
app/ # application source (Vite + Three.js)
terraform/ # infrastructure as code
ansible/ # configuration management


## 🚀 Setup

1. `terraform apply` inside `terraform/` — provisions VPC, EC2, security groups
2. Build and push the app image to ECR
3. SSM into the Ansible controller, `ansible-playbook playbook.yml`
4. Point Cloudflare DNS/Tunnel at the servers

## 📊 Monitoring

Prometheus scrapes `node_exporter` on the web server (port 9100), Grafana visualizes the metrics, and the dashboard is reachable securely through a Cloudflare Tunnel — no public ports exposed on the monitoring server.

