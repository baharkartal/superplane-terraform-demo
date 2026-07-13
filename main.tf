# 1. AWS Sağlayıcısını Tanımlıyoruz
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1" # Avrupa (Frankfurt) Sunucusu
}

# 2. Güvenlik Duvarı Ayarları
resource "aws_security_group" "superplane_demo_sg" {
  name        = "superplane-demo-sg"
  description = "SuperPlane demo amacli HTTP ve SSH trafigine izin verir"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 3. Sanal Sunucumuzu (EC2) Oluşturuyoruz
resource "aws_instance" "superplane_web_server" {
  ami           = "ami-0ec7f9846da69de16" # Ubuntu 22.04 LTS
  instance_type = "t2.micro"             # Ücretsiz paket

  vpc_security_group_ids = [aws_security_group.superplane_demo_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install nginx -y
              sudo systemctl start nginx
              echo "<h1>SuperPlane AI Agent & Engineer Demo Platform</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "SuperPlane-Demo-Instance"
    Role = "DevRel-Demo"
  }
}

# 4. Çıktı (IP Adresi)
output "server_public_ip" {
  value       = aws_instance.superplane_web_server.public_ip
  description = "Olusacak olan sunucunun internetteki acik IP adresi"
}