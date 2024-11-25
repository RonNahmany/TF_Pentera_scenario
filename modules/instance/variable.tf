variable "vpc_id" {
    type        = string
    description = "inhareting from network module"
}

variable "nameTag" {
    type    = string
    description = "Name tag from main"
  
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
variable "subnet_id" {
    type    = string
    description = "subnet from network module"
  
}

variable "instance_config" {
  description = "List of configuration to use in terraform"
  type = list(object({
    count         = number
    ami           = string
    instance_type = string 
  }))
  
}
