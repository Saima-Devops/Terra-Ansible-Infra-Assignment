output "web_public_ip" {
  value = aws_instance.web.public_ip
}

output "web_private_ip" {
  value = aws_instance.web.private_ip
}

output "mongodb_private_ip" {
  value = aws_instance.mongodb.private_ip
}
