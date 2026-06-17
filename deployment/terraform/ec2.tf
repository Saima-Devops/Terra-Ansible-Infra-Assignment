data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  subnet_id = aws_subnet.public.id

  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]

  key_name = aws_key_pair.mern_key.key_name

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "web-server"
  }
}

resource "aws_instance" "mongodb" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  subnet_id = aws_subnet.private.id

  vpc_security_group_ids = [
    aws_security_group.mongo_sg.id
  ]

  key_name = var.key_name

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "mongodb-server"
  }
}
