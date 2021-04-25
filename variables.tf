variable "domain_name" {
  description = "The name/fqdn of the Route53 Zone."
  type        = string
}

variable "kms_key_arn" {
  description = "The arn of the KMS key to sign this zone with."
  type        = string
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
