data aws_route53_zone aws_zone {
  name = "talandyael.com"
}

resource aws_route53_record lb {
  zone_id = data.aws_route53_zone.aws_zone.id
  name = "rtmp.talandyael.com"
  type = "A"

  alias {
    name = aws_lb.lb.dns_name
    zone_id = aws_lb.lb.zone_id
    evaluate_target_health = false
  }
}
