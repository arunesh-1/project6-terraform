terraform {
  required_version = ">= 1.4.0"
}

resource "terraform_data" "server" {
  input = {
    name        = var.server_name
    environment = var.environment
  }
}

output "server_configuration" {
  description = "Demo server configuration stored in Terraform state."
  value       = terraform_data.server.output
}
