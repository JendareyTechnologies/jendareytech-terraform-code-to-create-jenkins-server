terraform {
  backend "s3" {
    bucket = "jendareybucketclass"
    key    = "terraform/backend/jenkins-server/terraform.tfstate"
    region = "us-east-1"
  }
}
