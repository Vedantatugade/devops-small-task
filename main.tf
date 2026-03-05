provider "aws" {
  region = "us-east-1"
}

data "aws_subnets" "default" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0f3caa1cf4417e51b"
  instance_type = "t3.micro"
  key_name      = "my-tf-key"

  subnet_id = tolist(data.aws_subnets.default.ids)[0]

  tags = {
    Name = "devops-demo"
  }
}

output "ec2_ip" {
  value = aws_instance.web.public_ip
}