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
    "v=spf1 include:_spf.protonmail.ch -all"
  ]
  root_mx               = [
    "10 mail.protonmail.ch.",
    "20 mailsec.protonmail.ch."
    ]
  dmarc_value           = ["v=DMARC1; p=quarantine; sp=quarantine; pct=100; rua=mailto:dmarc@example.net"]
  protonmail_domainkey  = "protonmail.domainkey.00000000000000000000000000000000000000000000000000000.domains.proton.ch."
  protonmail2_domainkey = "protonmail2.domainkey.00000000000000000000000000000000000000000000000000000.domains.proton.ch."
  protonmail3_domainkey = "protonmail3.domainkey.00000000000000000000000000000000000000000000000000000.domains.proton.ch."
  github_verification_record = "000000000000"
  github_org_name            = "Lupus-Metallum"
}
```
