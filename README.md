# AWS Infrastructure Automation Demo for SuperPlane

This repository contains a complete, production-ready Terraform configuration to automate the deployment of a cloud infrastructure on AWS. 

## What This Code Deploys:
1. **AWS Provider:** Configured and pinned to the `eu-central-1` (Frankfurt) region.
2. **Security Group (`superplane_demo_sg`):** Configured with secure ingress rules allowing public HTTP traffic (Port 80) and secure SSH access (Port 22).
3. **EC2 Instance (`superplane_web_server`):** An Ubuntu 22.04 LTS virtual server bootstrapped automatically via `user_data` to install and launch an Nginx web server.
4. **Outputs:** A dynamic output block to instantly retrieve the public IP address of the deployed server.

## How to Run This Tutorial Locally:
To initialize the backend and verify the environment:
```bash
terraform init
terraform plan
