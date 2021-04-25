variable "vultr_access_key" {

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

    provisioner "remote-exec" {
      inline = [
        "apt-get install -y nodejs"
      ]
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