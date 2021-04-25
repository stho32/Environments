variable "vultr_access_key" { sensitive = true }
variable "ssh_key" { sensitive = true }
variable "private_key_file" { sensitive = true }

terraform {
  required_providers {
    vultr = {
      source = "vultr/vultr"
      version = "2.2.0"
    }
  }
}

# Configure the Vultr Provider
provider "vultr" {
  api_key = var.vultr_access_key
  rate_limit = 700
  retry_limit = 3
}

resource "vultr_instance" "testmachine" {
    plan = "vc2-4c-8gb"
    region = "fra"
    os_id = "387"
    label = "test machine 1"
    tag = ""
    hostname = "tm001"
    activation_email = false
    ssh_key_ids = [ var.ssh_key ]

    provisioner "local-exec" {
      command = "echo \"SERVER-IP ${self.main_ip}\""
    }

    provisioner "remote-exec" {
      inline = [
        "apt-get install -y nodejs"
      ]

      connection {
        type     = "ssh"
        host     = self.main_ip
        user     = "root"
        password = self.default_password
        timeout  = "2m"  
        #private_key = var.private_key_file
        #agent = true    
      }
    }
}
/*
resource "vultr_instance" "dc01" {
    plan = "vc2-4c-8gb"
    region = "fra"
    os_id = "387"
    label = "dc01"
    tag = ""
    hostname = "dc01"
    activation_email = false
}
*/