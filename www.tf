resource "aws_instance" "www" {
  ami           = lookup(var.amis, var.region)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.primary.id
  #vpc_security_group_ids = [
  #  aws_security_group.allow-http.id,
  #  aws_security_group.allow-all-outbound.id,
  #]
  user_data = file("setup-webserver.sh")
}

output "public-ip" {
  value = aws_instance.www.public_ip
}
