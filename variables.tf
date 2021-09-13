variable "domain_name" {
  description = "The name/fqdn of the Route53 Zone."
  type        = string
}

variable "dnssec" {
  description = "Should DNSSEC be enabled for this domain"
  type        = bool
  default     = true
}

variable "kms_key_arn" {
  description = "The arn of the KMS key to sign this zone with."
  type        = string
  default     = ""
}

variable "signing_key_name" {
  description = "The name to use for the DNSSEC signing key, must be alphanumeric only, no -, _, or spaces."
  default     = "DefaultSigningKey"
}

variable "ttl" {
  description = "The value to use in seconds for TTL of the DS records"
  default     = 300
  type        = number
}

variable "amazon_caa_record" {
  description = "Should we add a Certificate Authority Authorization Record for Amazon CA's?"
  default     = true
  type        = bool
}

variable "outlook_autodiscover" {
  description = "Should we create the autodiscover CNAME record that points to autodiscover.outlook.com?"
  default     = false
  type        = bool
}

variable "github_verification_record" {
  description = "Value of the GitHub verification record?"
  default     = ""
  type        = string
}

variable "github_org_name" {
  description = "Name of the GitHub org to add the record for?"
  default     = ""
  type        = string
}

variable "root_txt" {
  description = "Values to put in the root/apex TXT of the zone?"
  default     = []
  type        = list(string)
}

variable "root_mx" {
  description = "Values to put in the root/apex MX record of the zone?"
  default     = []
  type        = list(string)
}

variable "dmarc_value" {
  description = "Values to put in the root/apex dmarc record of the zone?"
  default     = []
  type        = list(string)
}

variable "protonmail_domainkey" {
  description = "Value to use for the first Protonmail DKIM CNAME Record, this is given in the custom domain setup page."
  default     = ""
  type        = string
}

variable "protonmail2_domainkey" {
  description = "Value to use for the second Protonmail DKIM CNAME Record, this is given in the custom domain setup page."
  default     = ""
  type        = string
}

variable "ms_domainkey" {
  description = "Value to use for the first Microsoft 365 DKIM CNAME Record, this is given in the https://security.microsoft.com/dkimv2 setup page."
  default     = ""
  type        = string
}

variable "ms_domainkey2" {
  description = "Value to use for the second Microsoft 365 DKIM CNAME Record, this is given in the https://security.microsoft.com/dkimv2 setup page."
  default     = ""
  type        = string
}

variable "protonmail3_domainkey" {
  description = "Value to use for the third Protonmail DKIM CNAME Record, this is given in the custom domain setup page"
  default     = ""
  type        = string
}

variable "stripe_domainkey1" {
  description = "Value to use for the first Stripe DKIM CNAME Record, this is given in the custom domain setup page. This should be the auto-generated text prior to '._domainkey.example.com'"
  default     = ""
  type        = string
}

variable "stripe_domainkey2" {
  description = "Value to use for the second Stripe DKIM CNAME Record, this is given in the custom domain setup page. This should be the auto-generated text prior to '._domainkey.example.com'"
  default     = ""
  type        = string
}

variable "stripe_domainkey3" {
  description = "Value to use for the third Stripe DKIM CNAME Record, this is given in the custom domain setup page. This should be the auto-generated text prior to '._domainkey.example.com'"
  default     = ""
  type        = string
}

variable "stripe_domainkey4" {
  description = "Value to use for the fourth Stripe DKIM CNAME Record, this is given in the custom domain setup page. This should be the auto-generated text prior to '._domainkey.example.com'"
  default     = ""
  type        = string
}

variable "stripe_domainkey5" {
  description = "Value to use for the fifth Stripe DKIM CNAME Record, this is given in the custom domain setup page. This should be the auto-generated text prior to '._domainkey.example.com'"
  default     = ""
  type        = string
}

variable "stripe_domainkey6" {
  description = "Value to use for the sixth Stripe DKIM CNAME Record, this is given in the custom domain setup page. This should be the auto-generated text prior to '._domainkey.example.com'"
  default     = ""
  type        = string
}

variable "stripe_bounce" {
  description = "Should we create the Stripe boune cname record"
  default     = false
  type        = bool
}

variable "atlassian_cloud_dkim" {
  description = "Should we create the Atlassian Cloud DKIM cname records"
  default     = false
  type        = bool
}

variable "tags" {
  description = "Tags to apply to tag-able resources"
  default     = {}
  type        = map(string)
}
