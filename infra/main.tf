provider "aws" {
  region = "us-east-1"
}

data "aws_ssm_parameter" "ubuntu" {
  name = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

resource "aws_instance" "my_ec2" {
  ami           = data.aws_ssm_parameter.ubuntu.value
  instance_type = "t2.micro"
  key_name      = "DevOps_caseStudy"

  tags = {
    Name = "devops-case-ec2"
  }
}

output "ec2_public_ip" {
  value = aws_instance.my_ec2.public_ip
}

