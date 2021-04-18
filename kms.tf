resource "aws_kms_key" "this" {
  count = var.dnssec == true ? 1 : 0
  description             = "Used to sign dnssec records"
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
      Name = "DNSSEC-Key",
    }

}


resource "aws_kms_alias" "this" {
  name          = "alias/${var.key_alias_name}"
  target_key_id = aws_kms_key.this.key_id
}