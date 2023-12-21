# Resource: EC2 Instance
resource "aws_instance" "jendarey-instance" {
  ami                    = data.aws_ami.ubuntu_ami.id
  instance_type          = var.INSTANCE[2]
  key_name               = "automationkey"
  user_data              = file("${path.module}/jenkins-server-script.sh")
  availability_zone      = var.ZONE1
  subnet_id              = aws_subnet.jendarey_public_subnet_a.id
  vpc_security_group_ids = [aws_security_group.jendarey-security_group.id]
  depends_on             = [aws_vpc.jendarey_vpc]
  for_each               = toset(var.COUNT)
  
  tags = {
    Name    = each.value
    Project = "Jendarey"
  }

  root_block_device {
    volume_size = 10
  }
}
