# Define the IAM role in Terraform
resource "aws_iam_role" "jenkins_eks_role" {
  name = "jenkins_eks_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"  # Assuming Jenkins runs on an EC2 instance
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
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"  # Full access policy
}

# Define the IAM instance profile
resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "jenkins_profile"
  role = aws_iam_role.jenkins_eks_role.name
}

# Associate the IAM instance profile with the Jenkins EC2 instance
resource "aws_instance" "jenkins_instance_server" {
  # ... other instance configuration ...

  iam_instance_profile = aws_iam_instance_profile.jenkins_profile.arn
}



