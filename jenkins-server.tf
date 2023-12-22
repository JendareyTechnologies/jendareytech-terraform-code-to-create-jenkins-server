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
  iam_instance_profile        = aws_iam_instance_profile.jenkins_profile.arn

  tags = {
    Name        = "jenkins-server-instance"
    Terraform   = "true"
    Environment = "production-server-eks"
  }
}

resource "aws_iam_role" "jenkins_eks_role" {
  name = "jenkins_eks_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Attach necessary policies to the IAM role
resource "aws_iam_role_policy_attachment" "jenkins_eks_full_access" {
  role       = aws_iam_role.jenkins_eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy" 
}

# Define the IAM instance profile
resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "jenkins_profile"
  role = aws_iam_role.jenkins_eks_role.name
}


