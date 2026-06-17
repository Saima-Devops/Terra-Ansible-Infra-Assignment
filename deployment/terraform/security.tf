resource "aws_security_group" "web_sg" {
  name        = "web-security-group"
  description = "Security Group for Web Server"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from my machine"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "HTTP"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Node API"

    from_port = 5000
    to_port   = 5000
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "React App"

    from_port = 3000
    to_port   = 3000
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

resource "aws_security_group" "mongo_sg" {
  name        = "mongo-security-group"
  description = "Security Group for MongoDB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "MongoDB from Web Server"

    from_port = 27017
    to_port   = 27017
    protocol  = "tcp"

    security_groups = [
      aws_security_group.web_sg.id
    ]
  }

  ingress {
    description = "SSH from Web Server"

    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    security_groups = [
      aws_security_group.web_sg.id
    ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mongo-sg"
  }
}
