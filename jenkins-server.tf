# Resource: EC2 Instance for Jenkins
resource "aws_instance" "jenkins-server-instance" {
  ami                         = data.aws_ami.ubuntu_ami.id
  instance_type               = var.INSTANCE[1]
  key_name                    = "automationkey"
  user_data                   = file("${path.module}/jenkins-server-script.sh")
  monitoring                  = true
  associate_public_ip_address = true  
  subnet_id                   = aws_subnet.jendarey_public_subnet_a.id  
  vpc_security_group_ids      = [aws_default_security_group.jendarey-default-sg.id]

  tags = {
    Name        = "jenkins-server-instance"
    Terraform   = "true"
    Environment = "prod"
  }
}
