variable "region" {
  type        = string
  default     = "il-central-1"
  description = "default region in aws"
}
variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "dns_support" {
  description = "Whether to enable DNS support in the VPC"
  type        = bool
}

variable "dns_hostname" {
  description = "Whether to enable DNS hostnames in the VPC"
  type        = bool
}

variable "work_subnet" {
  description = "The CIDR block for the work subnet"
  type        = string
}

variable "Tag" {
  type        = string
  description = "The TAG for the env"

}
variable "egressrules" {
  type = list(object({
    port        = number
    description = string
  }))
}
variable "ingressrules" {
  type = list(object({
    port        = number
    description = string
  }))
}

variable "instance_configs" {
  description = "List of configurations for machine groups"
  type = list(object({
    count         = number
    ami           = string
    instance_type = string
  }))
}