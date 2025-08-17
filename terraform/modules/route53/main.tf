resource "aws_route53_record" "alb_alias" {
  zone_id = "Z0952190E6PJC8Q98ZNX"  
  name    = "hassan114.click"
  type    = "A"

  alias {
    name                   = aws_lb.alb_dns_name
    zone_id                = aws_lb.alb_hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_acm_certificate" "cert" {
  domain_name       = "hassan114.click"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "acm_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => dvo
  }

  zone_id = "Z0952190E6PJC8Q98ZNX"  
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  ttl     = 60
  records = [each.value.resource_record_value]
}

resource "aws_acm_certificate_validation" "acm_cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for r in aws_route53_record.acm_cert_validation : r.fqdn]
}
