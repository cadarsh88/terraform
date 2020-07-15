provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c5b1a88222ac79cb"
  instance_type = "t2.micro"
}