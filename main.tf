provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami = "ami-0f3caa1cf4417e51b"
  instance_type = "t3.micro"
  key_name = "my-tf-key"

  tags = {
  Name = "devops-demo"
  }
}


output "ec2_ip" {
  value = aws_instance.web.public_ip
}