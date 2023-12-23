#!/bin/bash

# install jenkins

# Set the hostname and switch to the root user
sudo hostnamectl set-hostname jenkins-scripts
sudo timedatectl set-timezone America/Chicago

# Install necessary packages
sudo apt-get update
sudo apt-get install tree git wget openjdk-17-jdk -y
sudo apt-get install -y awscli

# Add Jenkins repository
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package list
sudo apt-get update 

# Install Jenkins
sudo apt-get install jenkins -y

# Reload systemd manager configuration
sudo systemctl daemon-reload

# Enable and start Jenkins service
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Add HashiCorp GPG key and repository
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update and install Terraform
sudo apt update && sudo apt install terraform -y

#finally install kubectl
sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mkdir -p $HOME/bin && sudo cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

