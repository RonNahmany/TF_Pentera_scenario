### Instance Config counter 

#/ Env name 
Tag          = "prod"

#/ Env counter and AMI image
instance_configs = [
  {
    count         = 2
    ami           = "ami-0d0e33c53ae589b94"  # Replace with the first AMI
    instance_type = "t3.micro"
    description   = "Linux Env machines"
  },
# Example of Windows or other config in the same network 
/*
  {
    count         = 5
    ami           = "ami-0a6272429abc5c6e9"  
    instance_type = "t2.small"
  }
*/
]

### General region Config ###
region       = "il-central-1"

#/ Network Config
cidr_block   = "15.0.0.0/16"
dns_support  = true
dns_hostname = true
work_subnet  = "15.0.1.0/24"
egressrules = [
  {
    port        = 0
    description = "All traffic"
  },
]
ingressrules = [
  {
    port        = 80
    description = "port 80"
  },
  {
    port        = 443
    description = "port 443"
  },
  {
    port        = 22
    description = "SSH port"
  }
]

