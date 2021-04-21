resource "aws_route53_zone" "this" {
  name = var.domain_name
}

resource "aws_route53_key_signing_key" "this" {
  count                      = var.dnssec == true ? 1 : 0
  hosted_zone_id             = aws_route53_zone.this.id
  key_management_service_arn = aws_kms_key.this[0].arn
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

#######
# KMS
#######
resource "aws_kms_key" "this" {
  count                    = var.dnssec == true ? 1 : 0
  description              = "Used to sign dnssec records"
  customer_master_key_spec = "ECC_NIST_P256"
  deletion_window_in_days  = var.deletion_window_days
  key_usage                = "SIGN_VERIFY"
  policy = jsonencode({
    Statement = [
      {
        Action = [
          "kms:DescribeKey",
          "kms:GetPublicKey",
          "kms:Sign",
        ],
        Effect = "Allow"
        Principal = {
          Service = "api-service.dnssec.route53.aws.internal"
        }
        Sid = "Route 53 DNSSEC Permissions"
      },
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Resource = "*"
        Sid      = "IAM User Permissions"
      },
    ]
    Version = "2012-10-17"
  })
  tags = {
    Name = "DNSSEC-Key-${replace(var.domain_name, ".", "-")}",
  }

}

resource "aws_kms_alias" "this" {
  count         = var.dnssec == true ? 1 : 0
  name          = "alias/${var.key_alias_name}-${replace(var.domain_name, ".", "-")}"
  target_key_id = aws_kms_key.this[0].key_id
}