resource "aws_route53_zone" "this" {
  name = var.domain_name
  tags = var.tags
}

resource "aws_route53_key_signing_key" "this" {
  count                      = var.dnssec == true ? 1 : 0
  hosted_zone_id             = aws_route53_zone.this.id
  key_management_service_arn = var.kms_key_arn
  name                       = var.signing_key_name
}

resource "aws_route53_hosted_zone_dnssec" "this" {
  count          = var.dnssec == true ? 1 : 0
  hosted_zone_id = aws_route53_key_signing_key.this[0].hosted_zone_id
}

resource "aws_route53_record" "this" {
  count   = var.dnssec == true ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = "@.${aws_route53_zone.this.name}"
  type    = "DS"
  ttl     = var.ttl

  records = [aws_route53_key_signing_key.this[0].ds_record]
}

resource "aws_route53_record" "txt_this" {
  count   = length(var.root_txt) > 0 ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = aws_route53_zone.this.name
  type    = "TXT"
  ttl     = var.ttl

  records = var.root_txt
}

resource "aws_route53_record" "mx_this" {
  count   = length(var.root_mx) > 0 ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = aws_route53_zone.this.name
  type    = "MX"
  ttl     = var.ttl

  records = var.root_mx
}

resource "aws_route53_record" "dmarc_this" {
  count   = length(var.dmarc_value) > 0 ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = "_dmarc.${aws_route53_zone.this.name}"
  type    = "TXT"
  ttl     = var.ttl
  records = var.dmarc_value
}

resource "aws_route53_record" "caa_this" {
  count   = var.amazon_caa_record == true ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = aws_route53_zone.this.name
  type    = "CAA"
  ttl     = var.ttl
  records = [
    "0 issue \"amazon.com\"",
    "0 issue \"amazonaws.com\"",
    "0 issue \"amazontrust.com\"",
    "0 issue \"awstrust.com\""
  ]
}

resource "aws_route53_record" "outlook_autodiscover_this" {
  count   = var.outlook_autodiscover == true ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = "autodiscover.${aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = var.ttl
  records = [
    "autodiscover.outlook.com"
  ]
}

resource "aws_route53_record" "github_this" {
  count   = var.github_verification_record != "" && var.github_org_name != "" ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = "_github-challenge-${var.github_org_name}.${aws_route53_zone.this.name}"
  type    = "TXT"
  ttl     = var.ttl
  records = [
    var.github_verification_record
  ]
}

resource "aws_route53_record" "protonmail_domainkey_this" {
  count   = length(var.protonmail_domainkey) > 0 ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = "protonmail._domainkey.${aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = var.ttl

  records = [var.protonmail_domainkey]
}
resource "aws_route53_record" "protonmail2_domainkey_this" {
  count   = length(var.protonmail2_domainkey) > 0 ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = "protonmail2._domainkey.${aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = var.ttl

  records = [var.protonmail2_domainkey]
}
resource "aws_route53_record" "protonmail3_domainkey_this" {
  count   = length(var.protonmail3_domainkey) > 0 ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = "protonmail3._domainkey.${aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = var.ttl

  records = [var.protonmail3_domainkey]
}
resource "aws_route53_record" "stripe_domainkey1_this" {
  count   = length(var.stripe_domainkey1) > 0 ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = "${var.stripe_domainkey1}._domainkey.${aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = var.ttl

  records = ["${var.stripe_domainkey1}.dkim.custom-email-domain.stripe.com."]
}
resource "aws_route53_record" "stripe_domainkey2_this" {
  count   = length(var.stripe_domainkey2) > 0 ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = "${var.stripe_domainkey2}._domainkey.${aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = var.ttl

  records = ["${var.stripe_domainkey2}.dkim.custom-email-domain.stripe.com."]
}
resource "aws_route53_record" "stripe_domainkey3_this" {
  count   = length(var.stripe_domainkey3) > 0 ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = "${var.stripe_domainkey3}._domainkey.${aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = var.ttl

  records = ["${var.stripe_domainkey3}.dkim.custom-email-domain.stripe.com."]
}
resource "aws_route53_record" "stripe_domainkey4_this" {
  count   = length(var.stripe_domainkey4) > 0 ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = "${var.stripe_domainkey4}._domainkey.${aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = var.ttl

  records = ["${var.stripe_domainkey4}.dkim.custom-email-domain.stripe.com."]
}
resource "aws_route53_record" "stripe_domainkey5_this" {
  count   = length(var.stripe_domainkey5) > 0 ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = "${var.stripe_domainkey5}._domainkey.${aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = var.ttl

  records = ["${var.stripe_domainkey5}.dkim.custom-email-domain.stripe.com."]
}
resource "aws_route53_record" "stripe_domainkey6_this" {
  count   = length(var.stripe_domainkey6) > 0 ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = "${var.stripe_domainkey6}._domainkey.${aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = var.ttl

  records = ["${var.stripe_domainkey6}.dkim.custom-email-domain.stripe.com."]
}
resource "aws_route53_record" "stripe_bounce_this" {
  count   = var.stripe_bounce == true ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = "bounce.${aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = var.ttl

  records = ["custom-email-domain.stripe.com."]
}
resource "aws_route53_record" "o365_domainkey_this" {
  count   = length(var.ms_domainkey) > 0 ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = "selector1._domainkey.${aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = var.ttl

  records = [var.ms_domainkey]
}
resource "aws_route53_record" "o365_domainkey_this2" {
  count   = length(var.ms_domainkey2) > 0 ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = "selector2._domainkey.${aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = var.ttl

  records = [var.ms_domainkey2]
}
resource "aws_route53_record" "atlassian_cloud_domainkey_this" {
  count   = var.atlassian_cloud_dkim == true ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = "s1._domainkey.${aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = var.ttl

  records = ["s1._domainkey.atlassian.net."]
}
resource "aws_route53_record" "atlassian_cloud_domainkey_this2" {
  count   = var.atlassian_cloud_dkim == true ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = "s2._domainkey.${aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = var.ttl

  records = ["s2._domainkey.atlassian.net."]
}