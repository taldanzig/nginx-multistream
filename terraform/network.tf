resource "aws_security_group" "multiplexer" {
  name        = "multiplexer"
  description = "Allow egress"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 1935
    to_port = 1935
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

