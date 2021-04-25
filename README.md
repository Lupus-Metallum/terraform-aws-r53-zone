# terraform-aws-r53-zone
TF Module for creating a R53 zone with DNSSEC, should be used in conjunction with lupus-metallum/dnssec-kms to create a key. This can be looped for unique keys per zone if desired. If a var.kms_key_arn is not specified, a zone with be created without DNSSEC.

## Example
``` Terraform
module "dnssec_key" {
  source   = "Lupus-Metallum/dnssec-kms/aws"
  version  = "1.0.0"
  
  name     = "my-dnssec-key"
}

module "my_dnssec_zone" {
  source   = "Lupus-Metallum/r53-zone/aws"
  version  = "1.0.9"
  
  domain_name      = "example.com"
  kms_key_arn      = module.dnssec_key.key_arn
  signing_key_name = "my-signing-key"
  ttl              = 300

}
```
