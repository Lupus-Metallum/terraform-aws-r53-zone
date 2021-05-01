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
  description = "Values to put in the root/apex MX of the zone?"
  default     = []
  type        = list(string)
}
