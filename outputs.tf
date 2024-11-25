output "instance_ip" {
  value = module.instance_create.instance_ip
  description = "All the outputs of the machines IP"
}

output "SSH_key"{
    sensitive = true
    value = module.instance_create.SSH_access
    description = "SSH key "
}


### Retreave the values , in actual pipeline this will be used for Ansible , Chef to provision ... 
### Assuming , as IaC i am using the same Keypair for the whole 
