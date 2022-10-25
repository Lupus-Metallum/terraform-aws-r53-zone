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

<!-- BEGIN_TF_DOCS -->

<img src="https://raw.githubusercontent.com/Lupus-Metallum/brand/master/images/logo.jpg" width="400"/>



## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_hosted_zone_dnssec.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_hosted_zone_dnssec) | resource |
| [aws_route53_key_signing_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_key_signing_key) | resource |
| [aws_route53_record.atlassian_cloud_bounce](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.atlassian_cloud_fallback_dkim](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.atlassian_cloud_primary_dkim](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.caa_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.dmarc_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.github_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.mx_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.o365_domainkey_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.o365_domainkey_this2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.outlook_autodiscover_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.protonmail2_domainkey_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.protonmail3_domainkey_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.protonmail_domainkey_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.stripe_bounce_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.stripe_domainkey1_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.stripe_domainkey2_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.stripe_domainkey3_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.stripe_domainkey4_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.stripe_domainkey5_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.stripe_domainkey6_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.txt_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The name/fqdn of the Route53 Zone. | `string` | n/a | yes |
| <a name="input_amazon_caa_record"></a> [amazon\_caa\_record](#input\_amazon\_caa\_record) | Should we add a Certificate Authority Authorization Record for Amazon CA's? | `bool` | `true` | no |
| <a name="input_atlassian_cloud_bounce"></a> [atlassian\_cloud\_bounce](#input\_atlassian\_cloud\_bounce) | Should we create the Atlassian Cloud bounce cname record | `bool` | `false` | no |
| <a name="input_atlassian_cloud_fallback_dkim"></a> [atlassian\_cloud\_fallback\_dkim](#input\_atlassian\_cloud\_fallback\_dkim) | Should we create the Atlassian Cloud DKIM fallback cname record | `string` | `""` | no |
| <a name="input_atlassian_cloud_primary_dkim"></a> [atlassian\_cloud\_primary\_dkim](#input\_atlassian\_cloud\_primary\_dkim) | Should we create the Atlassian Cloud DKIM primary cname record | `string` | `""` | no |
| <a name="input_dmarc_value"></a> [dmarc\_value](#input\_dmarc\_value) | Values to put in the root/apex dmarc record of the zone? | `list(string)` | `[]` | no |
| <a name="input_dnssec"></a> [dnssec](#input\_dnssec) | Should DNSSEC be enabled for this domain | `bool` | `true` | no |
| <a name="input_github_org_name"></a> [github\_org\_name](#input\_github\_org\_name) | Name of the GitHub org to add the record for? | `string` | `""` | no |
| <a name="input_github_verification_record"></a> [github\_verification\_record](#input\_github\_verification\_record) | Value of the GitHub verification record? | `string` | `""` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | The arn of the KMS key to sign this zone with. | `string` | `""` | no |
| <a name="input_ms_domainkey"></a> [ms\_domainkey](#input\_ms\_domainkey) | Value to use for the first Microsoft 365 DKIM CNAME Record, this is given in the https://security.microsoft.com/dkimv2 setup page. | `string` | `""` | no |
| <a name="input_ms_domainkey2"></a> [ms\_domainkey2](#input\_ms\_domainkey2) | Value to use for the second Microsoft 365 DKIM CNAME Record, this is given in the https://security.microsoft.com/dkimv2 setup page. | `string` | `""` | no |
| <a name="input_outlook_autodiscover"></a> [outlook\_autodiscover](#input\_outlook\_autodiscover) | Should we create the autodiscover CNAME record that points to autodiscover.outlook.com? | `bool` | `false` | no |
| <a name="input_protonmail2_domainkey"></a> [protonmail2\_domainkey](#input\_protonmail2\_domainkey) | Value to use for the second Protonmail DKIM CNAME Record, this is given in the custom domain setup page. | `string` | `""` | no |
| <a name="input_protonmail3_domainkey"></a> [protonmail3\_domainkey](#input\_protonmail3\_domainkey) | Value to use for the third Protonmail DKIM CNAME Record, this is given in the custom domain setup page | `string` | `""` | no |
| <a name="input_protonmail_domainkey"></a> [protonmail\_domainkey](#input\_protonmail\_domainkey) | Value to use for the first Protonmail DKIM CNAME Record, this is given in the custom domain setup page. | `string` | `""` | no |
| <a name="input_root_mx"></a> [root\_mx](#input\_root\_mx) | Values to put in the root/apex MX record of the zone? | `list(string)` | `[]` | no |
| <a name="input_root_txt"></a> [root\_txt](#input\_root\_txt) | Values to put in the root/apex TXT of the zone? | `list(string)` | `[]` | no |
| <a name="input_signing_key_name"></a> [signing\_key\_name](#input\_signing\_key\_name) | The name to use for the DNSSEC signing key, must be alphanumeric only, no -, \_, or spaces. | `string` | `"DefaultSigningKey"` | no |
| <a name="input_stripe_bounce"></a> [stripe\_bounce](#input\_stripe\_bounce) | Should we create the Stripe boune cname record | `bool` | `false` | no |
| <a name="input_stripe_domainkey1"></a> [stripe\_domainkey1](#input\_stripe\_domainkey1) | Value to use for the first Stripe DKIM CNAME Record, this is given in the custom domain setup page. This should be the auto-generated text prior to '.\_domainkey.example.com' | `string` | `""` | no |
| <a name="input_stripe_domainkey2"></a> [stripe\_domainkey2](#input\_stripe\_domainkey2) | Value to use for the second Stripe DKIM CNAME Record, this is given in the custom domain setup page. This should be the auto-generated text prior to '.\_domainkey.example.com' | `string` | `""` | no |
| <a name="input_stripe_domainkey3"></a> [stripe\_domainkey3](#input\_stripe\_domainkey3) | Value to use for the third Stripe DKIM CNAME Record, this is given in the custom domain setup page. This should be the auto-generated text prior to '.\_domainkey.example.com' | `string` | `""` | no |
| <a name="input_stripe_domainkey4"></a> [stripe\_domainkey4](#input\_stripe\_domainkey4) | Value to use for the fourth Stripe DKIM CNAME Record, this is given in the custom domain setup page. This should be the auto-generated text prior to '.\_domainkey.example.com' | `string` | `""` | no |
| <a name="input_stripe_domainkey5"></a> [stripe\_domainkey5](#input\_stripe\_domainkey5) | Value to use for the fifth Stripe DKIM CNAME Record, this is given in the custom domain setup page. This should be the auto-generated text prior to '.\_domainkey.example.com' | `string` | `""` | no |
| <a name="input_stripe_domainkey6"></a> [stripe\_domainkey6](#input\_stripe\_domainkey6) | Value to use for the sixth Stripe DKIM CNAME Record, this is given in the custom domain setup page. This should be the auto-generated text prior to '.\_domainkey.example.com' | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to tag-able resources | `map(string)` | `{}` | no |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | The value to use in seconds for TTL of the DS records | `number` | `300` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_name_servers"></a> [name\_servers](#output\_name\_servers) | n/a |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | n/a |
<!-- END_TF_DOCS -->