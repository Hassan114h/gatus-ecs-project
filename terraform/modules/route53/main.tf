
resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "acm_cert_validation" {
  zone_id = var.hosted_zone_id
  name    = aws_acm_certificate.cert.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options[0].resource_record_type
  ttl     = 60
  records = [aws_acm_certificate.cert.domain_validation_options[0].resource_record_value]
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.acm_cert_validation.fqdn]

  timeouts {
    create = "15m"
  }

  depends_on = [aws_route53_record.acm_cert_validation]
}

resource "aws_route53_record" "alb_alias" {
  zone_id = var.hosted_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_hosted_zone_id
    evaluate_target_health = true
  }

  depends_on = [aws_acm_certificate_validation.cert_validation]
}
