# AWS Security Group with Ingress and Egress Rules
resource "aws_security_group" "jendarey-security-group" {
  vpc_id      = module.jendarey_vpc.vpc_id
  name        = "jendarey-security-group"
  description = "Allow incoming traffic on ports 22, and 8080,"

  // Ingress rules (incoming traffic)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Egress rules (outgoing traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "jendarey-sg"
    Environment = "production"
  }
}

