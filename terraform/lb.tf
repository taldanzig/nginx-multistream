locals {
  subnet_ids = [
    aws_default_subnet.default_az1.id,
    aws_default_subnet.default_az2.id,
    aws_default_subnet.default_az3.id,
    aws_default_subnet.default_az4.id,
  ]

  rtmp_port = 1935
}

resource "aws_default_vpc" "default" {
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = "us-west-2a"
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = "us-west-2b"
}

resource "aws_default_subnet" "default_az3" {
  availability_zone = "us-west-2c"
}

resource "aws_default_subnet" "default_az4" {
  availability_zone = "us-west-2d"
}


resource "aws_security_group" "lb_ingress" {
  vpc_id      = aws_default_vpc.default.id
  name        = "Load Balancer Ingress"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = local.rtmp_port
    to_port     = local.rtmp_port
    protocol    = "tcp"
  }
}

resource "aws_lb" "lb" {
  name               = "lb"
  load_balancer_type = "network"
  subnets            = local.subnet_ids
}

resource "aws_lb_target_group" "rtmp" {
  name              = "rtmp-target"
  port              = local.rtmp_port
  protocol          = "TCP"
  target_type       = "ip"
  vpc_id            = aws_default_vpc.default.id
  proxy_protocol_v2 = false
}

resource "aws_lb_listener" "rtmp" {
  load_balancer_arn = aws_lb.lb.id
  port              = local.rtmp_port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rtmp.arn
  }
}
