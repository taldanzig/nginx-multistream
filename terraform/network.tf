resource "aws_security_group" "multiplexer" {
  name        = "multiplexer"
  description = "multiplexer ports"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port = local.rtmp_port
    to_port   = local.rtmp_port
    protocol  = "tcp"
    self      = true
  }

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    self      = true
  }
}

resource "aws_security_group" "egress" {
  name        = "egress-all"
  description = "allow egress"
  vpc_id      = aws_default_vpc.default.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ingress" {
  name        = "ingress-rtmp"
  description = "allow ingress"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port = local.rtmp_port
    to_port   = local.rtmp_port
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
