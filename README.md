# terraform-aws-r53-zone
TF Module for creating a R53 zone with DNSSEC, should be used in conjunction with lupus-metallum/dnssec-kms to create a key. This can be looped for unique keys per zone if desired. If a var.kms_key_arn is not specified, a zone with be created without DNSSEC.

## Example
``` Terraform
module "dnssec_key" {
  source   = "Lupus-Metallum/dnssec-kms/aws"
  version  = "1.0.4"
  
  name     = "my-dnssec-key"
}

module "r53_zone_example_net" {
  source  = "Lupus-Metallum/r53-zone/aws"
  version = "1.2.1"

  domain_name           = "example.net"
  dnssec                = true
  amazon_caa_record     = true
  outlook_autodiscover  = true
  kms_key_arn           = module.dnssec_key.key_arn
  signing_key_name      = "ExampleDefaultKey"
  root_txt              = [
    "protonmail-verification=0000000000000000000000",
    "v=spf1 include:_spf.protonmail.ch -all",
    "stripe-verification=000000000000",
  ]
  root_mx               = [
    "10 mail.protonmail.ch.",
    "20 mailsec.protonmail.ch."
    ]
  dmarc_value           = ["v=DMARC1; p=quarantine; sp=quarantine; pct=100; rua=mailto:dmarc@example.net"]
  protonmail_domainkey  = "protonmail.domainkey.00000000000000000000000000000000000000000000000000000.domains.proton.ch."
  protonmail2_domainkey = "protonmail2.domainkey.00000000000000000000000000000000000000000000000000000.domains.proton.ch."
  protonmail3_domainkey = "protonmail3.domainkey.00000000000000000000000000000000000000000000000000000.domains.proton.ch."
  ms_domainkey          = "selector1-0000000._domainkey.0000000.onmicrosoft.com"
  ms_domainkey2         = "selector2-0000000._domainkey.0000000.onmicrosoft.com"
  github_verification_record = "000000000000"
  github_org_name            = "Lupus-Metallum"
  stripe_domainkey1          = "000000000000"
  stripe_domainkey2          = "000000000000"
  stripe_domainkey3          = "000000000000"
  stripe_domainkey4          = "000000000000"
  stripe_domainkey5          = "000000000000"
  stripe_domainkey6          = "000000000000"
  stripe_bounce              = true
  atlassian_cloud_dkim       = true
}
```
