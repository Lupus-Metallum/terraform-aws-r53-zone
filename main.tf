locals {
  dnssec = length(var.kms_key_id) > 0 ? true : false
}


resource "aws_route53_zone" "this" {
  name = var.domain_name
}

resource "aws_route53_key_signing_key" "this" {
  count                      = local.dnssec == true ? 1 : 0
  hosted_zone_id             = aws_route53_zone.this.id
  key_management_service_arn = var.kms_key_arn
  name                       = var.signing_key_name
}

resource "aws_route53_hosted_zone_dnssec" "this" {
  count          = local.dnssec == true ? 1 : 0
  hosted_zone_id = aws_route53_key_signing_key.this[0].hosted_zone_id
}

resource "aws_route53_record" "this" {
  count   = local.dnssec == true ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = "@.${aws_route53_zone.this.name}"
  type    = "DS"
  ttl     = var.ttl

  records = [aws_route53_key_signing_key.this[0].ds_record]
}
