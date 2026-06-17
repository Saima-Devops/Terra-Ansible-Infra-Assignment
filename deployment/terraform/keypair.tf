resource "aws_key_pair" "mern_key" {
  key_name   = var.key_name
  public_key = file("${path.module}/keys/mern-key.pub")

  tags = {
    Name = "mern-key"
  }
}
