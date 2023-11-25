resource "aws_instance" "ubuntu_node1" {
  ami             = "ami-06dd92ecc74fdfb36"
  instance_type   = "t2.micro"
  key_name        = "stephan"
  security_groups = [aws_security_group.my_security_group.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt upgrade -y
              EOF

  tags = {
    Name  = "Ubuntu - Target Node 1"
    Stage = "dev"
    Team  = "payments"
  }
}

resource "aws_instance" "ubuntu_node2" {
  ami             = "ami-06dd92ecc74fdfb36"
  instance_type   = "t2.micro"
  key_name        = "stephan"
  security_groups = [aws_security_group.my_security_group.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt upgrade -y
              EOF

  tags = {
    Name  = "Ubuntu - Target Node 2"
    Stage = "prod"
    Team  = "payments"
  }
}

output "public_ip" {
  value = aws_instance.ubuntu_node1.public_ip
}

output "public_ip2" {
  value = aws_instance.ubuntu_node2.public_ip
}

resource "aws_security_group" "my_security_group" {
  name_prefix = "my-sg-"

  # Fully public inbound rules for SSH, HTTP, and HTTPS.
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ssh"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "https"
  }

  # Fully public outbound rules.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all outbound traffic"
  }

  tags = {
    Name = "AnsibleSecurityGroup"
  }
}
