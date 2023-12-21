variable "REGION" {
  default = "us-east-1"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "ZONE2" {
  default = "us-east-1b"
}

variable "INSTANCE" {
  type    = list(string)
  default = ["t2.small", "t2.medium", "t2.micro"]
}

variable "USER" {
  default = "ubuntu"
}

variable "PUB_KEY" {
  default = "jendareykey.pub"
}

variable "PRIV_KEY" {
  default = "jendareykey"
}

variable "COUNT" {
  type    = list(string)
  default = ["jendarey-dev", "jendarey-prod"]
}
