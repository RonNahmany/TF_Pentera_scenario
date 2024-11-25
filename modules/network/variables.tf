variable "network_config" {
    description     = "network configuration"
    type            = object({
      cidr_block    = string
      dns_support   = bool
      dns_hostname  = bool
      work_subnet   = string
    })
    default = {
      cidr_block    = "15.0.0.0/16"
      dns_support   = true
      dns_hostname  = true
      work_subnet   = "15.0.1.0/24"
    }
    
}

variable "global_provision_tag" {
    description = "global tags for network provision"
    type = string
    default = "TF_Provision"
  
}
